import 'package:ecommerce_user_app/db/db_helper.dart';
import 'package:ecommerce_user_app/models/order_constant_model.dart';
import 'package:flutter/foundation.dart';

class OrderProvider extends ChangeNotifier{
  OrderConstantModel orderConstantModel = OrderConstantModel();
  final _db = DbHelper();

  getOrderConstants() {
    _db.getOrderConstants().listen((snapshot) {
       orderConstantModel = OrderConstantModel.fromJson(snapshot.data()!);
      notifyListeners();

    });
  }

  num getDiscountAmount(num subTotal){
   return (subTotal * orderConstantModel.discount) / 100;

  }

  num getVatAmount(num subTotal){
   final totalAfterDiscount = subTotal - getDiscountAmount(subTotal);
   return (totalAfterDiscount * orderConstantModel.vat) /100;
  }

  num getGrandTotal(num subTotal){
    return  (subTotal - getDiscountAmount(subTotal)) + orderConstantModel.deliveryCharge + getVatAmount(subTotal);
  }
}