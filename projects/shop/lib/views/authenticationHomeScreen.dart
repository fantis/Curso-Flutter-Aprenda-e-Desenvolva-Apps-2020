import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/authentication.dart';
import 'package:shop/views/authenticationScreen.dart';
import 'package:shop/views/productOverviewScreen.dart';

class AuthenticationOrHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Authentication authentication = Provider.of(context);


    return authentication.isAuthenticate
        ? ProductOverviewScreen()
        : AuthenticationScreen();
  }
}
