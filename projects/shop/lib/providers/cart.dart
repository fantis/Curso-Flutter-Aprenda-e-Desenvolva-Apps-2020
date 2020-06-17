import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/product.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return this._items.length;
  }

  double get totalAmount {
    double total = 0.0;
    this._items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (this._items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existItem) => CartItem(
          id: existItem.id,
          productId: existItem.productId,
          title: existItem.title,
          quantity: existItem.quantity + 1,
          price: existItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random.secure().nextDouble().toString(),
          productId: product.id,
          title: product.title,
          quantity: 1,
          price: product.price,
        ),
      );
    }

    // notifying listeners related
    notifyListeners();
  }

  void removeItem(String productId) {
    this._items.remove(productId);

    // notifying listeners related
    notifyListeners();
  }
}
