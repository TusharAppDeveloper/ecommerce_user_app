import 'package:ecommerce_user_app/pages/cart_page.dart';
import 'package:ecommerce_user_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/product_item_view.dart';
import '../providers/product_provider.dart';

class ViewProductPage extends StatelessWidget {
  static const String routeName = '/viewProduct';

  const ViewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    Provider.of<CartProvider>(context, listen: false).getAllCartItems();
    return Scaffold(
      appBar: AppBar(
        title: const Text('View products'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, CartPage.routeName),
            icon: const Icon(Icons.shopping_cart,size: 30,),
          )
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => provider.productList.isEmpty
            ? const Center(
                child: Text('No products found'),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 0.65),
                itemCount: provider.productList.length,
                itemBuilder: (context, index) {
                  final product = provider.productList[index];
                  return ProductItemView(
                    product: product,
                  );
                },
              ),
      ),
    );
  }
}
