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

    // return FutureBuilder(
    //   future: authentication.tryAutoLogin(),
    //   builder: (ctx, snapshot) {
    //     print("AuthenticationOrHomeScreen 1");
    //     print(snapshot.connectionState.toString());

    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     } else if (snapshot.error != null) {
    //       return Center(child: Text('Ocorreu um erro inesperado'));
    //     } else {
    //       return authentication.isAuthenticate
    //           ? ProductOverviewScreen()
    //           : AuthenticationScreen();
    //     }
    //   },
    // );
  }
}
