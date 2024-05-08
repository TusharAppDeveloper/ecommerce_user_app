import 'package:ecommerce_user_app/custom_widgets/cart_item_view.dart';
import 'package:ecommerce_user_app/pages/checkout_page.dart';
import 'package:ecommerce_user_app/providers/cart_provider.dart';
import 'package:ecommerce_user_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static const String routeName = '/cart';

  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) =>(provider.cartList.isEmpty) ? const Center(child: Text('no item found'),)  :
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: provider.cartList.length,
                itemBuilder: (context, index) {
                  final cart = provider.cartList[index];
                  return CartItemView(
                    cartModel: cart,
                    priceWithQuantity: provider.priceWithQuantity(cart),
                    onDecrease: (cart) {
                      provider.decreaseCartQuantity(cart);
                    },
                    onIncrease: (cart) {
                      provider.increaseCartQuantity(cart);
                    },
                    onDelete: (pid) {
                      provider.removeFromCart(pid);
                    },
                  );
                },
              ),
            ),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal : $currencySymbol${provider.getCartSubtotal}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.pushNamed(context, CheckoutPage.routeName),
                      child: const Text('Checkout'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
