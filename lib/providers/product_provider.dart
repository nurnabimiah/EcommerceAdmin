
import 'package:firebase_demo/db/firestore_helper.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier{

 List<String> categoryList = [];



 Future <bool> checkAdmin(String email){
 return FireStoreHelper.checkAdmin(email);
  }

  void getAllCategories(){
   FireStoreHelper.getCategories().listen((snapshot) {
    categoryList = List.generate(snapshot.docs.length, (index) =>
    snapshot.docs[index].data()['name']);
    notifyListeners();

   });
  }

}
