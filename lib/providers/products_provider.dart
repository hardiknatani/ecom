import 'package:ecom/data/products_data.dart';
import 'package:flutter/material.dart';

import 'product.dart';

class   ProductsProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
        id: 1,
        title: 'Banana',
        description: "description",
        imageUrl: "https://images.immediate.co.uk/production/volatile/sites/30/2017/01/Bananas-218094b-scaled.jpg",
        price: 20),
    Product(
        id: 2,
        title: 'Orange',
        description: "description",
        imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTJFW0AaaaDWz7AzrVtOeCVrptS_uf2d5W4g&usqp=CAU",
        price: 20),
    Product(
        id: 3,
        title: 'Kiwi',
        description: "description",
        imageUrl: "https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/09/kiwi-1296x728-header.jpg?w=1155&h=1528",
        price: 20),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(int id) {
    return _items.firstWhere((element) => element.id == id);
  }

    void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

   addProduct(Product value) {
    _items.add(value);
    notifyListeners();
  }

    void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
