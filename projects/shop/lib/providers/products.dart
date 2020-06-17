import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/data/dummyData.dart';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;
  // List<Product> _items = [];

  List<Product> get items => [ ..._items ];
  // List<Product> get items {
  //   List<Product> newItems;
  //   for (var item in items) {
  //     newItems.add(item);
  //   }
  // }

  void addProduct(Product product) {
    this._items.add(product);
    notifyListeners();
  }
}
