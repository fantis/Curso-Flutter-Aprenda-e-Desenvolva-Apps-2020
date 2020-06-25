import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/order.dart';
import 'package:shop/widgets/appDrawer.dart';
import 'package:shop/widgets/orderWidget.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<Orders>(context, listen: false).loadOrders().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Orders orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orders.itemsCount,
              itemBuilder: (ctx, i) => OrderWidget(orders.items[i]),
            ),
    );
  }
}
