import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_user_app/models/cart_model.dart';
import 'package:ecommerce_user_app/utils/constants.dart';
import 'package:flutter/material.dart';

class CartItemView extends StatelessWidget {
  const CartItemView({
    super.key,
    required this.cartModel,
    required this.priceWithQuantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
  });

  final CartModel cartModel;
  final num priceWithQuantity;
  final Function(CartModel) onIncrease;
  final Function(CartModel) onDecrease;
  final Function(String pid) onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: CachedNetworkImage(
              width: 70,
              height: 70,
              imageUrl: cartModel.imageUrl,
              placeholder: (context, url) =>
                  Image.asset('images/placeholder.png'),
            ),
            title: Text(cartModel.productName),
            subtitle: Text('Unit price: $currencySymbol${cartModel.price}'),
            trailing: Text(
              '$currencySymbol${priceWithQuantity.toStringAsFixed(1)}', style: const TextStyle(fontSize: 20),),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  onDecrease(cartModel);
                },
                icon: const Icon(Icons.remove_circle),
              ),
              Text(
                '${cartModel.quantity}', style: const TextStyle(fontSize: 20),),
              IconButton(
                onPressed: () {
                  onIncrease(cartModel);
                },
                icon: const Icon(Icons.add_circle),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  onDelete(cartModel.productId);

                },
                icon: const Icon(Icons.delete),
              )
            ],
          )
        ],
      ),
    );
  }
}
