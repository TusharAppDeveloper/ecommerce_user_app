import 'package:ecommerce_user_app/providers/cart_provider.dart';
import 'package:ecommerce_user_app/providers/order_provider.dart';
import 'package:ecommerce_user_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  static const String routeName = '/checkout';

  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderProvider>(context ,listen: false).getOrderConstants();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout page'),
      ),
      body: ListView(
        children: [
          _buildItemsSection(),
          _buildOrderSummerySection(context,Provider.of<CartProvider>(context , listen: false).getCartSubtotal),
        ],
      ),
    );
  }

  Widget _buildItemsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<CartProvider>(
          builder: (context, provider, child) => Column(
            children: [
              const Text(
                'Items',
                style: TextStyle(fontSize: 20),
              ),
              const Divider(
                color: Colors.black,
                height: 2,
              ),
              for (final cart in provider.cartList)
                ListTile(
                  title: Text(cart.productName),
                  trailing: Text(
                    '${cart.quantity} x ${cart.price}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummerySection(context,num subTotal) {
    var provider = Provider.of<OrderProvider>(context ) ;
    return   Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Order Summery',
              style: TextStyle(fontSize: 20),
            ),
            const Divider(
              color: Colors.black,
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Subtotal'),
                  Text(
                    '$currencySymbol$subTotal',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Delivery charge'),
                  Text(
                    '$currencySymbol${provider.orderConstantModel.deliveryCharge}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Discount(${provider.orderConstantModel.discount}%)'),
                  Text(
                    '-$currencySymbol${provider.getDiscountAmount(subTotal)}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('VAT(${provider.orderConstantModel.vat}%)'),
                  Text(
                    '$currencySymbol${provider.getVatAmount(subTotal)}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Grand Total',style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold),),
                  Text(
                    '$currencySymbol${provider.getGrandTotal(subTotal)}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )




          ],
        ),
      ),
    );
  }
}
