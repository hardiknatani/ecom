import 'dart:core';

import 'package:ecom/widgets/OrderItem.dart';
import 'package:ecom/widgets/cartItem.dart';
import 'package:flutter/cupertino.dart';


class Order {
    final int id;
  final String dateTime;
  final double amount;
  final List<CartItem> products;

  Order(
      {required this.id,
      required this.dateTime,
      required this.amount,
      required this.products});

}

class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return _orders;
  }

  void addOrders(order) {
    _orders.add(order);
    notifyListeners();
  }
}
