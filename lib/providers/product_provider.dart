
import 'package:firebase_demo/db/firestore_helper.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier{



 Future <bool> checkAdmin(String email){
 return FireStoreHelper.checkAdmin(email);
  }

}
