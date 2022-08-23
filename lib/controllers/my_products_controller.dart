import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:swapp2/models/bid_item_card.dart';

class MyProductsController extends GetxController {
  List<Widget> itemList = [];
  static List<int> selectItems = [];
  static List<String> selectedItemID = [];


  @override
  void onInit() {
    super.onInit();
    getMyItems();
  }

  @override
  void onReady() {
    super.onReady();
    selectItems.clear();
  }

// fetch products from firebase
  getMyItems() async {
    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    await _firebaseFirestore
        .collection('products')
        .where('owner', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (value) {
        for (var element in value.docs) {
        
          itemList.add(BidItemCard(
            name: element.data()['name'],
            cashValue: element.data()['cashValue'],
            image: element.data()['image'],
            category: element.data()['category'],
            id: element.id,
          ));
        }
      },
    );

    update();
  }

  @override
  void onClose() {
    super.onClose();
    selectItems.clear();
  }
}
