import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop/util/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _toggleFavorite() async {
    this.isFavorite = !this.isFavorite;
    notifyListeners();
  }

  Future<void> toogleFavorite() async {
    this._toggleFavorite();

    try {
      final String url = '${Constants.BASE_API_URL}products/$id.json';
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': isFavorite,
          }));

      if (response.statusCode >= 400) {
        this._toggleFavorite();
      }
    } catch (error) {
      this._toggleFavorite();
    }
  }
}
