import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier{
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];
  final _db = DbHelper();
  


  void getAllCategories(){
    _db.getAllCategories().listen((snapShot) {
      categoryList =  List.generate(snapShot.docs.length, (index) =>
      CategoryModel.fromJson(snapShot.docs[index].data())
      );
      notifyListeners();
    });
  }

  void getAllProducts(){
    _db.getAllProducts().listen((snapShot) {
      productList =  List.generate(snapShot.docs.length, (index) =>
          ProductModel.fromJson(snapShot.docs[index].data())
      );
      notifyListeners();
    });
  }

  Future<String> uploadImage(String localImagePath) async{
    final imageName = 'product_${DateTime.now().millisecondsSinceEpoch}';
    final imageRef = FirebaseStorage.instance.ref().child('Pictures/$imageName');
    final uploadTask = imageRef.putFile(File(localImagePath));
    final snapshot =  await uploadTask.whenComplete(() => null);
    return await snapshot.ref.getDownloadURL();
  }


}