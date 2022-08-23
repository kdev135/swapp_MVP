import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swapp2/components/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapp2/screens/bid_screen.dart';
import 'package:swapp2/screens/catalog_screen.dart';

class ProductInfoScreen extends StatelessWidget {
  ProductInfoScreen({Key? key}) : super(key: key);

  /// image, label, details, value, category
  final List prod = Get.arguments;
  final String? _userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
          shadowColor: Colors.white.withOpacity(0),
          backgroundColor: Colors.white.withOpacity(0),
          leading: BackButton(
            onPressed: () {
              Get.off(() => CatalogScreen());
            },
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text(
                'Cash value: ${prod[3].toString()}',
                style: GoogleFonts.montserrat(fontSize: 15),
              ),
              ElevatedButton(
                  child: Text(
                    'Bid',
                    style: titleStyle,
                  ),
                  onPressed: () {
                    if (prod[5] == _userID) {
                      Get.snackbar('Message',
                          'You own this product, you cannot bid on it',
                          duration: const Duration(seconds: 3),
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      Get.to(() => const BidScreen(), arguments: prod);
                    }
                  })
            ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
                height: 300,
                child: Image(image: NetworkImage(prod[0].toString()))),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  prod[1].toString(),
                  style: titleStyle,
                  softWrap: true,
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_outline_rounded),
                  onPressed: () {},
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(prod[2].toString(),
                style: GoogleFonts.montserrat(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
