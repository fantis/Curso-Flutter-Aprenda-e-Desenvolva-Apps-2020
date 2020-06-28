import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/authenticationException.dart';

class Authentication with ChangeNotifier {
  // https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]
  // https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]
  // static const _url =
  //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBdDjMO8S4dor1rs0T4jN09AUckcJcBZYI';

  String _userId;
  String _token;
  DateTime _expireDate;

  bool get isAuthenticate {
    return token != null;
  }

  String get userId {
    print(isAuthenticate);
    print(_userId);
    print('==============');

    return isAuthenticate ? this._userId : null;
  }

  String get token {
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
      print('_authenticate 1');
      print(_token);
      print(_userId);
      print('_authenticate 2');
      this._expireDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseBody["expiresIn"]),
        ),
      );

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
}
