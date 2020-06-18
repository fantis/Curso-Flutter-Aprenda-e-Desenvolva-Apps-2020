import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/cart.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  Order({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.date,
  });
}

class Orders with ChangeNotifier {
  List<Order> _order = [];

  List<Order> get orders {
    return [..._order];
  }

  void addOrder(Cart cart) {
    final anotherTotal = cart.items.values.toList().fold(
          0.0,
          (previousValue, element) =>
              previousValue + (element.price * element.quantity),
        );

    this._order.insert(
          0,
          new Order(
            id: Random.secure().nextDouble().toString(),
            amount: cart.totalAmount,
            products: cart.items.values.toList(),
            date: DateTime.now(),
          ),
        );

    notifyListeners();
  }
}
