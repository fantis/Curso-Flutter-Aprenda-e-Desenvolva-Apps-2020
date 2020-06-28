import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/order.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/providers/authentication.dart';

import 'package:shop/util/appRoutes.dart';

import 'package:shop/views/authenticationHomeScreen.dart';
import 'package:shop/views/authenticationScreen.dart';
import 'package:shop/views/ordersScreen.dart';
import 'package:shop/views/productDetailScreen.dart';
import 'package:shop/views/productFormScreen.dart';
import 'package:shop/views/productOverviewScreen.dart';
import 'package:shop/views/cartScreen.dart';
import 'package:shop/views/productsScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Authentication(),
        ),
        ChangeNotifierProxyProvider<Authentication, Products>(
          create: (_) => new Products(),
          update: (ctx, authentication, previousProducts) => new Products(
            authentication.token,
            authentication.userId,
            previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => new Cart(),
        ),
        ChangeNotifierProxyProvider<Authentication, Orders>(
          create: (_) => new Orders(null, []),
          update: (ctx, authentication, previousOrders) => new Orders(
            authentication.token,
            previousOrders.items,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoutes.AUTHENTICATION_OR_HOME: (ctx) =>
              AuthenticationOrHomeScreen(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
          AppRoutes.CART: (ctx) => CartScreen(),
          AppRoutes.ORDERS: (ctx) => OrdersScreen(),
          AppRoutes.PRODUCTS: (ctx) => ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormScreen(),
        },
      ),
    );
  }
}
