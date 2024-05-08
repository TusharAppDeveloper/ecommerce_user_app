import 'dart:async';

import 'package:ecommerce_user_app/auth/auth_service.dart';
import 'package:ecommerce_user_app/db/db_helper.dart';
import 'package:ecommerce_user_app/models/product_model.dart';
import 'package:flutter/foundation.dart';

import '../models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartList = [];
  final _db = DbHelper();

  bool isInCart(String pid){
    bool flag = false;
    for(final cart in cartList){
      if(cart.productId == pid){
        flag = true;
        break;
      }
    }
    return flag;
  }

  Future<void> addToCart(ProductModel productModel) {
    final cartModel = CartModel(
      productId: productModel.productId!,
      productName: productModel.productName,
      imageUrl: productModel.imageUrl!,
      price: productModel.priceAfterDiscount,
    );
    
    return _db.addToCart(cartModel, AuthService.uid);
  }

  Future<void> removeFromCart(String pid) {


    return _db.removeFromCart(pid, AuthService.uid);
  }

  Future<void> increaseCartQuantity(CartModel cartModel) {
    final increasedQuantity = cartModel.quantity + 1;
    return _db.updateCartQuantity(AuthService.uid, cartModel.productId, increasedQuantity);
  }

  Future<void>? decreaseCartQuantity(CartModel cartModel) {
    if(cartModel.quantity > 1){
      final decreasedQuantity = cartModel.quantity - 1;
      return _db.updateCartQuantity(AuthService.uid, cartModel.productId, decreasedQuantity);
    }
    return null;
  }

  num priceWithQuantity(CartModel cartModel) => cartModel.price * cartModel.quantity;

  void getAllCartItems(){
    _db.getAllCartItems(AuthService.uid).listen((snapShot) {
      cartList =  List.generate(snapShot.docs.length, (index) =>
          CartModel.fromJson(snapShot.docs[index].data())
      );
      notifyListeners();
    });
  }

  num get getCartSubtotal {
    num total = 0;
    for(final cart in cartList){
      total += priceWithQuantity(cart);
    }
    return total;
  }
}

extension on ProductModel {
  num get priceAfterDiscount => price - ((price * discount) / 100);


}
