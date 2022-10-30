import 'dart:convert';
import 'dart:core';

import 'package:ecom/widgets/OrderItem.dart';
import 'package:ecom/widgets/cartItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Order {
  late String? id;
  final String dateTime;
  final double amount;
  final List<CartItem> products;

  Order(
      {this.id,
      required this.dateTime,
      required this.amount,
      required this.products});
}

class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return _orders;
  }

  Future<void> fetchOrders() async {
    print('fetching');
    var url =
        'https://ecom-backend-74ecd-default-rtdb.firebaseio.com/orders.json';

    try {
      final response = await http.get(Uri.parse(url));
      var ordersMap = Map.from(json.decode(response.body));
      final List<Order> loadedOrders = [];
      ordersMap.forEach((orderId, orderData) {
        loadedOrders.add(Order(
            id: orderId,
            dateTime: DateTime.parse(orderData['dateTime']).toString(),
            amount: orderData['amount'],
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                    productId: item['productId'], quantity: item['quantity']))
                .toList()));
      });
      _orders = loadedOrders;
    } catch (error) {
      notifyListeners();
      print(error);
      throw (error);
    }
  }

  Future<void> addOrders(Order order) async {
    var timeStamp = DateTime.now().toIso8601String();
    var url =
        'https://ecom-backend-74ecd-default-rtdb.firebaseio.com/orders.json';
    await http
        .post(Uri.parse(url),
            body: json.encode({
              'amount': order.amount,
              'dateTime': timeStamp,
              'products': order.products.map((cartProduct) {
                print(cartProduct);

                return {
                  'productId': cartProduct.productId,
                  'quantity': cartProduct.quantity
                };
              }).toList()
            }))
        .then((response) {
      print(response);
      order.id = jsonDecode(response.body)['name'];
    });
    _orders.add(order);
    notifyListeners();
  }
}
