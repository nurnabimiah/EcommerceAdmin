
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/db/firestore_helper.dart';
import 'package:firebase_demo/models/product_model.dart';
import 'package:firebase_demo/models/purchase_model.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier{

 List<String> categoryList = [];
 /*ai category list tai kinto new product page er items:
   _productProvider.categoryList.map protiti category niye niye ekta kore
   DropdownMenuItem jar child hosse ek ekta text  */
 List<ProductModel> productList = [];

 List<PurchaseModel> purchaseList = [];

 init(){
  _getAllCategories();
  _getAllProducts();
 }



 Future <bool> checkAdmin(String email){
 return FireStoreHelper.checkAdmin(email);
  }

  void _getAllCategories(){
   FireStoreHelper.getCategories().listen((snapshot) {
    categoryList = List.generate(snapshot.docs.length, (index) =>
    snapshot.docs[index].data()['name']);
    notifyListeners();

   });
  }


 /* sob gula product query korar jonno get all product ai method ta call korte hobe  and amra jevabe
    all catagory tole niye assi category thekhe*/
 void _getAllProducts() {
  FireStoreHelper.getAllProducts().listen((snapshot) {
   productList = List.generate(snapshot.docs.length,(index)=> ProductModel.fromMap(snapshot.docs[index].data()));

   notifyListeners();


  });

 }

  //add product
  Future<void> insertNewProduct (ProductModel productModel,PurchaseModel purchaseModel){
  return FireStoreHelper.addNewProduct(productModel, purchaseModel);


  }


  // ekta document k se tole niye asbe like product id ta ke se tole niye asbe
 Stream<DocumentSnapshot<Map<String,dynamic>>>getProductByProductId(String id) => FireStoreHelper.getProductByProductId(id);


 void getPurchasesByProductId(String id) {
  FireStoreHelper.getAllPurchaseByProductId(id).listen((snapshot) {
   purchaseList = List.generate(snapshot.docs.length, (index) =>
       PurchaseModel.fromMap(snapshot.docs[index].data()));

   notifyListeners();
  });


  void getPurchasesByProductId(String id) {
   FireStoreHelper.getAllPurchaseByProductId(id).listen((snapshot) {
    purchaseList = List.generate(snapshot.docs.length, (index) =>
        PurchaseModel.fromMap(snapshot.docs[index].data()));

    notifyListeners();
   });
  }
 }
 }




