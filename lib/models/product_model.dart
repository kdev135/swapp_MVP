import 'package:cloud_firestore/cloud_firestore.dart';

// Template for a product for the catalog screen.

class Product {
  late String image ;

  final String label;

   final int value;

  final String category;

  final String details;

  final String owner;

    Product(
      {required this.image,
      required this.label,
      required this.value,
      required this.category,
      required this.details,required this.owner});

  static Product fromSnapshot(DocumentSnapshot snap) {
  
    Product product = Product(
      
        image: snap['image'],
        label: snap['name'],
        value: snap['cashValue'],
        category: snap['category'],
        details: snap['info'],
        owner: snap['owner']);
    return product;
  }
}





