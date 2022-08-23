import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swapp2/models/bid_item_card.dart';

//create a list of all the items
class MyProductsList extends StatelessWidget {
  const MyProductsList({Key? key}) : super(key: key);
  static List<Widget> productList = [];

  getMyItems(var theList) async {
    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    await _firebaseFirestore
        .collection('products')
        .where('owner', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (value) {
        for (var element in value.docs) {
          
          theList.add(BidItemCard(
              name: element.data()['name'],
              cashValue: element.data()['cashValue'],
              image: element.data()['image'],
              category: element.data()['category'],
              id: element.id,));
          
        }
      },
    );
    return theList;
  }

  @override
  Widget build(BuildContext context) {
  
    return Column(
      children: productList,
    );
  }
}
