import 'package:ecom/pages/cart_page.dart';
import 'package:ecom/pages/orders.dart';
import 'package:ecom/pages/productOverview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return Drawer(
      child: ListView(
        children: [
          ListTile(
            onTap: () {
              navigator.pushNamed('/');
            },
            leading: Icon(Icons.shop_2_outlined),
            title: Text("Products"),
          ),
          ListTile(
                onTap: (){
                  navigator.pushNamed(OrdersPage.routeName);
                },
            leading: Icon(Icons.money),
            title: Text("Orders"),
          ),
                    ListTile(
                onTap: (){
                  navigator.pushNamed(CartPage.routeName);
                },
            leading: Icon(Icons.money),
            title: Text("Cart"),
          ),
          ListTile(
            leading: Icon(Icons.add_home),
            title: Text("My Products"),
          )
        ],
      ),
    );
  }
}
