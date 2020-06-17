import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/data/dummyData.dart';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  void addProduct(Product product) {
    this._items.add(product);
    notifyListeners();
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
