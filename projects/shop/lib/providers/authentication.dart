import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/authenticationException.dart';

class Authentication with ChangeNotifier {
  // https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]
  // https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]
  // static const _url =
  //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBdDjMO8S4dor1rs0T4jN09AUckcJcBZYI';

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
