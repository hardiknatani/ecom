import 'package:ecom/providers/orders_provider.dart';
import 'package:ecom/widgets/OrderItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<OrderProvider>(context, listen: false).fetchOrders();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar( 
        title: Text('Your Orders'),
      ),
      body: ListView(
          children: orderData.orders.map((order) => OrderItem(order)).toList()),
    );
  }
}
