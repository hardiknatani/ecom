import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavourite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price,
      this.isFavourite = false});

  toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
