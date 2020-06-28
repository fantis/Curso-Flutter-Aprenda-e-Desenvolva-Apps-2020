import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/store.dart';
import 'package:shop/exceptions/authenticationException.dart';

class Authentication with ChangeNotifier {
  // https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]
  // https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]
  // static const _url =
  //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBdDjMO8S4dor1rs0T4jN09AUckcJcBZYI';

  String _userId;
  String _token;
  DateTime _expireDate;
  Timer _logoutTimer;

  bool get isAuthenticate {
    print("Authentication: ${token != null}");
    return token != null;
  }

  String get userId {
    return isAuthenticate ? this._userId : null;
  }

  String get token {
    print("get token");
    print(_token);
    print(_expireDate);
    print(DateTime.now());
    // print(_expireDate.isAfter(DateTime.now()));

    if (_token != null &&
        _expireDate != null &&
        _expireDate.isAfter(DateTime.now())) {
      return _token;
    } else {
      return null;
    }
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBdDjMO8S4dor1rs0T4jN09AUckcJcBZYI";

    final response = await http.post(
      url,
      body: json.encode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );

    final responseBody = json.decode(response.body);

    if (responseBody["error"] != null) {
      throw AuthenticationException(responseBody["error"]["message"]);
    } else {
      this._token = responseBody["idToken"];
      this._userId = responseBody["localId"];
      this._expireDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseBody["expiresIn"]),
        ),
      );

      Store.saveMap(
        'userData',
        {
          "token": this._token,
          "userId": this._userId,
          "expireDate": this._expireDate.toIso8601String(),
        },
      );

      this._autoLogout();

      notifyListeners();
    }

    return Future.value();
  }

  Future<void> signup(String email, String password) async {
    return this._authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return this._authenticate(email, password, "signInWithPassword");
  }

  Future<void> tryAutoLogin() async {
    print('tryAutoLogin 1');
    if (this.isAuthenticate) {
      return Future.value();
    }

    print('tryAutoLogin 2');
    final userData = await Store.getMap('userData');
    if (userData == null) {
      return Future.value();
    }

    print('tryAutoLogin 3');
    final expireDate = DateTime.parse(userData['expireDate']);
    if (expireDate.isBefore(DateTime.now())) {
      return Future.value();
    }

    print('tryAutoLogin 4');
    print(userData["userId"]);
    print(userData["token"]);
    print(userData["expireDate"]);
    print('tryAutoLogin 5');

    this._userId = userData["userId"];
    this._token = userData["token "];
    this._expireDate = expireDate;

    print('tryAutoLogin 6');
    this._autoLogout();
    this.notifyListeners();

    print('tryAutoLogin 7');
    return Future.value();
  }

  void logout() {
    this._token = null;
    this._userId = null;
    this._expireDate = null;

    if (this._logoutTimer != null) {
      this._logoutTimer.cancel();
      this._logoutTimer = null;
    }

    Store.remove('userData');

    notifyListeners();
  }

  void _autoLogout() {
    if (this._logoutTimer != null) {
      this._logoutTimer.cancel();
    }

    final timeToLogout = _expireDate.difference(DateTime.now()).inSeconds;

    this._logoutTimer = Timer(Duration(seconds: timeToLogout), this.logout);
  }
}
