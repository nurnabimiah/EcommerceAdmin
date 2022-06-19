
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper{

  static const String _collectionAdmin = 'Admins';
  static const String _collectionCategory = 'Categories';


  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> checkAdmin( String email ) async{
    final snapshot = await _db.collection(_collectionAdmin)
        .where('email',isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
    
  }

  //amra database thekhe categories k tole niye astasi
  static Stream<QuerySnapshot<Map<String,dynamic>>> getCategories() => _db.collection(_collectionCategory).snapshots();





}