import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/data/dummyData.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/widgets/productItem.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final producsProvider = Provider.of<Products>(context);
    final products = producsProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ProductItem(products[i]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
