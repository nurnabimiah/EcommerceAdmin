
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/models/product_model.dart';
import 'package:firebase_demo/models/purchase_model.dart';

class FireStoreHelper{

  static const String _collectionAdmin = 'Admins';
  static const String _collectionCategory = 'Categories';
  static const String _collectionProduct = 'Products';
  static const String _collectionPurchases = 'Purchases';



  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> checkAdmin( String email ) async{
    final snapshot = await _db.collection(_collectionAdmin)
        .where('email',isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
    
  }

  //amra database thekhe categories k tole niye astasi
  static Stream<QuerySnapshot<Map<String,dynamic>>> getCategories() => _db.collection(_collectionCategory).snapshots();
  /*get categoroes ta call korle se oi collection thekeh sobgolo documents tole niye
  aese snapshot er strem ta ke se return korbe ai method ta call korbo product provider theke */


  static Future<void> addNewProduct (ProductModel productModel,PurchaseModel purchaseModel){
    final wb = _db.batch();
    final productDocRef =_db.collection(_collectionProduct).doc();
    final purchaseDocRef=_db.collection(_collectionPurchases).doc();
    productModel.id = productDocRef.id;
    purchaseModel.productId = productDocRef.id;
    wb.set(productDocRef, productModel.toMap());
    wb.set(purchaseDocRef, purchaseModel.toMap());
    return wb.commit();

  }
// getAllCategories
  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllProducts() => _db.collection(_collectionProduct).snapshots();

  // products details page a kiso jinis show korbo
  // aikhane matro ekta bisoy k tole niye asbe
  static Stream<DocumentSnapshot<Map<String,dynamic>>> getProductByProductId(String id) => _db.collection(_collectionProduct).doc(id).snapshots();


  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllPurchaseByProductId(String id) => _db.collection(_collectionPurchases).where('productId',isEqualTo:id ).snapshots();


}








