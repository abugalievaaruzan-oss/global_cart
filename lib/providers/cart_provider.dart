
import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  int get itemCount => _cartItems.length;

  double get totalPrice {
    return _cartItems.fold(
      0,
      (sum, item) => sum + item.price,
    );
  }

  bool isInCart(Product product) {
    return _cartItems.any((item) => item.id == product.id);
  }

  void addToCart(Product product) {
    if (!isInCart(product)) {
      _cartItems.add(product);
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    _cartItems.removeWhere(
      (item) => item.id == product.id,
    );
    notifyListeners();
  }

  void toggleCart(Product product) {
    if (isInCart(product)) {
      removeFromCart(product);
    } else {
      addToCart(product);
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
