import 'package:ecom/pages/cart_page.dart';
import 'package:ecom/providers/cart_provider.dart';
import 'package:ecom/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecom/pages/orders.dart';
import 'package:ecom/pages/productOverview.dart';
import 'package:ecom/pages/product_detail.dart';
import 'package:ecom/pages/tabs_screen.dart';
import './providers/products_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider()
          )
      ],
      child: MaterialApp(
        title: 'E-com',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => ProductOverview(),
          ProductDetail.routeName: (ctx) => ProductDetail(),
          OrdersPage.routeName: (ctx) => OrdersPage(),
          CartPage.routeName: ((context) => CartPage())
        },
      ),
    );
  }
}
