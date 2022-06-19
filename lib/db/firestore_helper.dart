
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper{

  static const String _collectionAdmin = 'Admins';


  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> checkAdmin( String email ) async{
    final snapshot = await _db.collection(_collectionAdmin)
        .where('email',isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
    
  }





}