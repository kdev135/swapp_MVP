import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swapp2/components/styles.dart';
import 'package:swapp2/controllers/my_products_controller.dart';
import 'package:swapp2/screens/catalog_screen.dart';

class MyItemsScreen extends StatelessWidget {
  MyItemsScreen({Key? key}) : super(key: key);

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    GetBuilder<MyProductsController> myItems = GetBuilder<MyProductsController>(
      init: MyProductsController(),
      builder: (val) => Column(children: val.itemList),
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () {
              if (MyProductsController.selectedItemID.isEmpty) {
                Get.snackbar('select something',
                    'You need to select at least one item to delete.');
                print('${MyProductsController.selectedItemID.length}');
              } else if (MyProductsController.selectedItemID.isNotEmpty) {
                (context as Element).markNeedsBuild();
                for (var id in MyProductsController.selectedItemID) {
                  _items.doc(id).delete().then((value) {
                    MyProductsController.selectedItemID.clear();
                    Get.snackbar('Delete successful',
                        'Item has been removed successfully.');
                    Get.off(() => CatalogScreen());
                  }).catchError((err) {
                    Get.snackbar('Something went wrong', '$err');
                  });
                }
              } else {
                Get.snackbar('Something went wrong', 'try again later.');
              }
              build(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text('My items', style: titleStyle),
            const SizedBox(height: 50),
            myItems,
          ],
        ),
      ),
    );
  }
}
