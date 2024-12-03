import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shopping Cart App',
      home: ProductPage(),
    );
  }
}

class ShoppingController extends GetxController {
  var cart = <Product>[].obs;

  void addToCart(Product product) {
    cart.add(product);
  }

  void removeFromCart(Product product) {
    cart.remove(product);
  }
}

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

class ProductPage extends StatelessWidget {
  final ShoppingController controller = Get.put(ShoppingController());

  final List<Product> products = [
    Product('Apple', 1.99),
    Product('Banana', 0.99),
    Product('Orange', 1.49),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Get.to(CartPage()),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: ElevatedButton(
              onPressed: () {
                controller.addToCart(product);
                Get.snackbar(
                  'Added to Cart',
                  '${product.name} added to cart',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: Duration(seconds: 1),
                );
              },
              child: Text('Add to Cart'),
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final ShoppingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Obx(() {
        if (controller.cart.isEmpty) {
          return Center(child: Text('Cart is empty.'));
        }
        return ListView.builder(
          itemCount: controller.cart.length,
          itemBuilder: (context, index) {
            final product = controller.cart[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () {
                  controller.removeFromCart(product);
                  Get.snackbar(
                    'Removed from Cart',
                    '${product.name} removed from cart',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: Duration(seconds: 1),
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
