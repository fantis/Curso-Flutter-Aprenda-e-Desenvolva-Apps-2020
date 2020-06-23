import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummyData.dart';
import 'package:shop/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];

  int get itemsCount {
    return this._items.length;
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://rubenscp-flutter-shop.firebaseio.com/products.json';

    final response = await http.post(
      url,
      body: json.encode(
        {
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        },
      ),
    );

    this._items.add(new Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        ));
    notifyListeners();
  }

  void updateProduct(Product product) {
    if (product == null || product.id == null) {
      return;
    }

    final index = this._items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      this._items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final index = this._items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      this._items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }
}

// bool _showFavoriteOnly = false;

// List<Product> get items {
//   print('classe Products Provider ');
//   print(_showFavoriteOnly);
//   if (_showFavoriteOnly) {
//     return _items.where((prod) => prod.isFavorite).toList();
//   }
//   return [..._items];
// }

// List<Product> get items {
//   List<Product> newItems;
//   for (var item in items) {
//     newItems.add(item);
//   }
//   return newItems;
// }

// void showFavorityOnly() {
//   _showFavoriteOnly = true;
//   print('marcou somente favoritos ');
// }

// void showAll() {
//   _showFavoriteOnly = false;
//   print('marcou todos ');
// }
