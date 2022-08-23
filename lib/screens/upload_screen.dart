import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swapp2/components/constants.dart';
import 'package:swapp2/models/custom_texfield.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swapp2/screens/catalog_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? imageFile;
  String? itemName;
  int? cashValue;
  String? category;
  String? image;
  String? info;
  String? imagePath;
  // ignore: prefer_typing_uninitialized_variables
  var path;
  // late ImageSource method;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: kContentPadding,
          child: ListView(
            children: [
              imagePath == null
                  ? const Placeholder(
                      strokeWidth: 1.0,
                      fallbackHeight: 200,
                      fallbackWidth: 150,
                    )
                  : Image.file(
                      File(path),
                      height: 250,
                    ),
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: () async {
                        var val = await getImage(ImageSource.camera);
                        setState(() {
                          imagePath = val;
                          path = imagePath.toString();
                        });
                      },
                      child: const Text('Camera upload')),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: OutlinedButton(
                      onPressed: () async {
                        var val = await getImage(ImageSource.gallery);
                        setState(() {
                          imagePath = val;
                          path = imagePath.toString();
                        });
                      },
                      child: const Text('Gallery upload')),
                ),
              ]),
              const SizedBox(
                height: 40,
              ),
              CustomTextField(
                  label: 'Name of item',
                  onChanged: (value) {
                    itemName = value;
                  }),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  label: 'Estimated value',
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    cashValue = int.parse(value);
                  }),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  label: 'Category',
                  onChanged: (value) {
                    category = value;
                  }),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  maxLines: 5,
                  label: 'Details',
                  onChanged: (value) {
                    info = value;
                  }),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (cashValue == null ||
                        info == null ||
                        itemName == null ||
                        category == null ||
                        imagePath == null) {
                           Get.snackbar(
                          'Missing value', 'All the fields must be filled to complete upload.',
                          duration: const Duration(seconds: 4));
                     
                    } else {
                      await uploadProduct(
                          imagePath: imagePath,
                          name: itemName.toString(),
                          value: cashValue!.toInt(),
                          info: info,
                          category: category);
                    }
                  },
                  child: const Text('Upload')),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> getImage(var imgMethod) async {
  ImageSource method = imgMethod;
  final _picker = ImagePicker();
  XFile? image;
  String? file;
  image = await _picker.pickImage(source: method);
  file = image!.path;

  return file.toString();
}

uploadProduct({imagePath, name, required int value, category, info}) async {
  try {
    TaskSnapshot product = await FirebaseStorage.instance
        .ref('catalog/$name')
        .putFile(File(imagePath));
    await product.ref
        .getDownloadURL()
        .then((val) {
          FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
          firebaseFirestore.collection('products').add({
            'cashValue': value,
            'category': category,
            'image': val,
            'info': info,
            'name': name,
            'owner': FirebaseAuth.instance.currentUser!.uid
          });
        })
        .whenComplete(() => Get.snackbar(
            'Success', 'Product has uploaded successfully.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3)))
        .then((value) => Get.offAll(() => CatalogScreen()));
  } catch (e) {
    //
  }
}
