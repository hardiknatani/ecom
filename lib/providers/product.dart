import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  late String? id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavourite;

  Product(
      {this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price,
      this.isFavourite = false});

  Future<void> toggleFavourite() async {
    final oldStatus = isFavourite;

    isFavourite = !isFavourite;
    notifyListeners();
    final url =
        'https://ecom-backend-74ecd-default-rtdb.firebaseio.com/products/$id.json';
    try {
      await http.patch(Uri.parse(url),
          body: jsonEncode({'isFavourite': isFavourite}));
    } catch (error) {
      isFavourite = oldStatus;
    }
  }
}
