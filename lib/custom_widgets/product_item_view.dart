import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_user_app/models/product_model.dart';
import 'package:ecommerce_user_app/providers/cart_provider.dart';
import 'package:ecommerce_user_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductItemView extends StatelessWidget {
  final ProductModel product;

  const ProductItemView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  imageUrl: product.imageUrl!,
                  placeholder: (context, url) =>
                      Image.asset('images/placeholder.png'),
                ),
                if (product.discount > 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    width: 70,
                    child: Text(
                      '${product.discount}% OFF',
                      style: const TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Consumer<CartProvider>(

                    builder:(context, provider, child) {
                      final isInCart = provider.isInCart(product.productId!);

                      return IconButton(
                        onPressed: (){
                          if(isInCart){
                         provider.removeFromCart(product.productId!);
                         showMsg(context, 'removed from cart');
                          }else{
                            provider.addToCart(product);
                            showMsg(context, 'added to cart');
                          }
                        },
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white
                        ),
                        icon: Icon(isInCart ? Icons.remove_shopping_cart : Icons.add_shopping_cart,),
                      );
                    }  ,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              product.productName,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          if (product.discount == 0)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '$currencySymbol${product.price}',
                style: const TextStyle(color: Colors.black45, fontSize: 22),
              ),
            ),
          if (product.discount > 0)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: RichText(
                text: TextSpan(
                  text: '$currencySymbol${product.price}',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                  children: [
                    TextSpan(
                      text: ' $currencySymbol${product.priceAfterDiscount}',
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                    )
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: product.avgRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Text('(${product.avgRating})')
              ],
            ),
          )
        ],
      ),
    );
  }
}

extension on ProductModel {
  num get priceAfterDiscount => price - ((price * discount) / 100);
}
