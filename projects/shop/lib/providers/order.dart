import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/cart.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({
    @required this.id,
    @required this.total,
    @required this.products,
    @required this.date,
  });
}

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return this._items.length;
  }

  void addOrder(Cart cart) {
    // final anotherTotal = cart.items.values.toList().fold(
    //       0.0,
    //       (previousValue, element) =>
    //           previousValue + (element.price * element.quantity),
    //     );

    this._items.insert(
          0,
          new Order(
            id: Random.secure().nextDouble().toString(),
            total: cart.totalAmount,
            products: cart.items.values.toList(),
            date: DateTime.now(),
          ),
        );

    notifyListeners();
  }
}
