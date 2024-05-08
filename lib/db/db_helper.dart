import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_app/models/app_user_model.dart';
import 'package:ecommerce_user_app/models/cart_model.dart';



class DbHelper{
  final _db = FirebaseFirestore.instance;
  final String collectionAdmin = 'Admin';
  final String collectionCategory = 'Categories';
  final String collectionProduct = 'Products';
  final String collectionUser = 'Users';
  final String collectionCart = 'MyCart';
  final String collectionSettings = 'Settings';
  final String documentOrderConstant = 'OrderConstants';



  Future<void> addNewUser(AppUserModel userModel){
    return _db.collection(collectionUser).doc(userModel.uid).set(userModel.toJson());
  }

  Future<void> addToCart(CartModel cartModel , String uid) {
    return _db.collection(collectionUser)
        .doc(uid).collection(collectionCart)
        .doc(cartModel.productId)
        .set(cartModel.toJson());
  }

  Future<void> removeFromCart(String pid, String uid) {
    return _db.collection(collectionUser)
        .doc(uid).collection(collectionCart)
        .doc(pid)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories(){
    return _db.collection(collectionCategory).orderBy('name').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts(){
    return _db.collection(collectionProduct).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getOrderConstants(){
    return _db.collection(collectionSettings).doc(documentOrderConstant).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCartItems(String uid){
    return _db.collection(collectionUser)
        .doc(uid)
        .collection(collectionCart)
        .snapshots();
  }

  Future<void> updateCartQuantity(String uid , String pid , num quantity) {
    return _db.collection(collectionUser)
        .doc(uid)
        .collection(collectionCart)
        .doc(pid)
        .update({'quantity' : quantity});
  }




}