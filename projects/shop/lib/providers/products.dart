import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/httpException.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/util/constants.dart';

class Products with ChangeNotifier {
  final String _baseUrl = '${Constants.BASE_API_URL}products';
  List<Product> _items = [];
  String _token;
  String _userId;

  Products([
    this._token,
    this._userId,
    this._items = const [],
  ]);

  List<Product> get items => [..._items];

  int get itemsCount {
    return this._items.length;
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> loadProducts() async {
    final response = await http.get("$_baseUrl.json?auth=$_token");
    Map<String, dynamic> data = json.decode(response.body);

    final favoriteResponse = await http.get(
        "${Constants.BASE_API_URL}userFavorites/$_userId.json?auth=$_token");
    final favoriteMap = json.decode(favoriteResponse.body);

    this._items.clear();

    if (data != null) {
      data.forEach((productId, productData) {
        final isFavorite =
            favoriteMap == null ? false : favoriteMap[productId] ?? false;

        this._items.add(
              new Product(
                id: productId,
                title: productData['title'],
                description: productData['description'],
                price: productData['price'],
                imageUrl: productData['imageUrl'],
                isFavorite: isFavorite,
              ),
            );
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      "${_baseUrl}.json?auth=$_token",
      body: json.encode(
        {
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
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

  Future<void> updateProduct(Product product) async {
    if (product == null || product.id == null) {
      return;
    }

    final index = this._items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      await http.patch(
        "$_baseUrl/${product.id}.json?auth=$_token",
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );
      this._items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = this._items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      final product = this._items[index];
      this._items.remove(product);
      notifyListeners();

      final response =
          await http.delete("$_baseUrl/${product.id}.json?auth=$_token");

      if (response.statusCode >= 400) {
        this._items.insert(index, product);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto.');
      }
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
