import 'package:ecom/providers/product.dart';
import 'package:ecom/widgets/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void addItem(
    int productId,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId.toString(),
        (existingCartItem) => CartItem(
          productId: existingCartItem.productId,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId.toString(),
        () => CartItem(
          productId: productId,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
