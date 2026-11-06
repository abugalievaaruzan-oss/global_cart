
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  static const List<Product> products = [
    Product(id: 1, name: 'Laptop', price: 1200, emoji: '💻'),
    Product(id: 2, name: 'Headphones', price: 150, emoji: '🎧'),
    Product(id: 3, name: 'Smartphone', price: 900, emoji: '📱'),
    Product(id: 4, name: 'Keyboard', price: 80, emoji: '⌨️'),
    Product(id: 5, name: 'Mouse', price: 40, emoji: '🖱️'),
    Product(id: 6, name: 'Watch', price: 250, emoji: '⌚'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CartScreen(),
                        ),
                      );
                    },
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 4,
                      top: 3,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Consumer<CartProvider>(
            builder: (context, cart, child) {
              final added = cart.isInCart(product);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Text(
                    product.emoji,
                    style: const TextStyle(fontSize: 35),
                  ),
                  title: Text(product.name),
                  subtitle: Text('\$${product.price}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      cart.toggleCart(product);
                    },
                    child: Text(
                      added ? 'Remove' : 'Add to Cart',
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
