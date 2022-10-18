import 'package:ecom/providers/orders_provider.dart';
import 'package:ecom/widgets/OrderItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView(
          children: orderData.orders.map((order) => OrderItem(order)).toList()
              ),
    );
  }
}
