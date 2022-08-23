import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swapp2/models/product_model.dart';


// Get documents from Firebase and create objects of with the Product model class
class FirestoreDB {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
          
        
          
          
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

 
}

