import 'dart:math';

import 'package:ecom/providers/cart_provider.dart';
import 'package:ecom/providers/orders_provider.dart';
import 'package:ecom/providers/products_provider.dart';
import 'package:ecom/widgets/OrderItem.dart';
import 'package:ecom/widgets/cartItem.dart';
import 'package:ecom/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/cart';
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var total = 0.0;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final products = Provider.of<ProductsProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);

    void totalAmount() {

      total = 0;
      products.items.forEach(((product) {
        if (cart.items.containsKey(product.id.toString())) {
          setState(() {
            total = total +
                product.price *
                    cart.items[product.id.toString()]!.quantity.toInt();
          });
        }
      }));
    }

    totalAmount();

    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        total.toString(),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    OutlinedButton(
                      child: Text('ORDER NOW'),
                      onPressed: () {
                        orderProvider.addOrders(Order(
                            // id: new Random().nextInt(100),
                            dateTime: "18/10/2022",
                            amount: total,
                            products: cart.items.values.toList()));
                        cart.clearCart();
                        // setState(() {
                        //   total = 0;
                        // });
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartItem(
                  productId: cart.items.values.toList()[i].productId,
                  quantity: cart.items.values.toList()[i].quantity,
                ),
              ),
            )
          ],
        ));
  }
}
