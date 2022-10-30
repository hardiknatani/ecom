import 'dart:math';

import 'package:ecom/data/products_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'product.dart';

class ProductsProvider with ChangeNotifier {
  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(productsUrl));
      var itemsMap = Map.from(json.decode(response.body));
      final List<Product> loadedProducts = [];
      itemsMap.forEach((key, value) {
        loadedProducts.add(Product(
            description: value['description'],
            id: key,
            title: value['title'],
            imageUrl: value['imageUrl'],
            price: value['price'],
            isFavourite: value['isFavourite']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      notifyListeners();
      print(error);
      throw error;
    }
  }

  final productsUrl =
      "https://ecom-backend-74ecd-default-rtdb.firebaseio.com/products.json";

  List<Product> _items = [
    // Product(
    //     id: 1,
    //     title: 'Banana',
    //     description: "description",
    //     imageUrl:
    //         "https://images.immediate.co.uk/production/volatile/sites/30/2017/01/Bananas-218094b-scaled.jpg",
    //     price: 20),
    // Product(
    //     id: 2,
    //     title: 'Orange',
    //     description: "description",
    //     imageUrl:
    //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTJFW0AaaaDWz7AzrVtOeCVrptS_uf2d5W4g&usqp=CAU",
    //     price: 20),
    // Product(
    //     id: 3,
    //     title: 'Kiwi',
    //     description: "description",
    //     imageUrl:
    //         "https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/09/kiwi-1296x728-header.jpg?w=1155&h=1528",
    //     price: 20),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future updateProduct(String id, Product newProduct) async {
    var prodIndex = _items.indexWhere((prod) => prod.id == id);
    // var prodIndex2 = _items.firstWhere((element) => element.id == id);
    _items.forEach(
      (element) {
        print(element.id);
        if (element.id == id) {
          print(id);
        }
      },
    );
    print(prodIndex);
    // print(prodIndex2);
    if (prodIndex >= 0) {
      final patchUrl =
          'https://ecom-backend-74ecd-default-rtdb.firebaseio.com/products/$id.json';

      await http.patch(Uri.parse(patchUrl),
          body: jsonEncode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
            'isFavourite': false
          }));

      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> addProduct(Product product) {
    return http
        .post(Uri.parse(productsUrl),
            body: jsonEncode({
              // 'id': new Random().nextInt(100),
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
              'isFavourite': false
            }))
        .then((value) {
      var id = jsonDecode(value.body)['name'];
      product.id = id;
      _items.add(product);

      notifyListeners();
    });
  }

  Future deleteProduct(String id) async {
    print(id);
    final deleteUrl =
        'https://ecom-backend-74ecd-default-rtdb.firebaseio.com/products/$id.json';

    await http.delete(Uri.parse(deleteUrl));
    _items.removeWhere((product) {
      return product.id == id;
    });
    notifyListeners();
  }
}
