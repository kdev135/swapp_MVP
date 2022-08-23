

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:swapp2/components/constants.dart';
import 'package:swapp2/components/styles.dart';
import 'package:swapp2/controllers/product_controller.dart';
import 'package:swapp2/models/drawer_item.dart';
import 'package:swapp2/models/product_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swapp2/screens/login_screen.dart';
import 'package:swapp2/screens/my_items_screen.dart';
import 'package:swapp2/screens/upload_screen.dart';


class CatalogScreen extends StatelessWidget {
     CatalogScreen({Key? key}) : super(key: key);
  final productController = Get.put(ProductController());
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white70,
          shadowColor: Colors.black26,
          title: Center(
              child: Hero(
            child: swappLogo,
            tag: 'logo',
          )),
        ),
        floatingActionButton: FloatingActionButton.small(
            tooltip: 'Upload your item ',
            child: Icon(Icons.add),
            onPressed: () => Get.to(() => UploadScreen())),
        drawer: Drawer(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Some Name'),
              accountEmail: Text(_auth.currentUser!.email.toString()),
              currentAccountPicture: const CircleAvatar(
                maxRadius: 30.0,
                child: Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
            ),
            DrawerItem(
              icon: Icons.person,
              label: 'Profile',
              onTap: () {},
            ),
            DrawerItem(
              icon: Icons.format_list_bulleted,
              label: 'My items',
              onTap: () {
                Get.to(() => MyItemsScreen());
              },
            ),
            DrawerItem(
              icon: Icons.logout,
              label: 'Log out',
              onTap: () {
                _auth
                    .signOut()
                    .then((value) => Get.offAll(() => LoginScreen()));
              },
            ),
          ],
        )),
        body: Center(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              // The ListView is used here to allow for scrolling of the page except the search field above.
              Column(
                children: [
                  Container(
                    // Container as parent of the textField
                    padding: kContentPadding,
                    child: const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'eg. GTA V, Samsung galaxy s9, paintings',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // shrinkWrap: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Categories',
                            style: titleStyle,
                          ),
                        ),
                        Wrap(
                          spacing: 5.0,
                          children: const [
                            Chip(
                              label: Text('Cameras'),
                            ),
                            Chip(label: Text('Laptops')),
                            Chip(label: Text('Books')),
                            Chip(label: Text('Jeans')),
                            Chip(label: Text('Artwork')),
                            Chip(label: Text('Furniture')),
                            Chip(label: Text('Appliances')),
                            Chip(label: Text('Televisions')),
                            Chip(label: Text('Misc.')),
                          ],
                        ),
                        Obx(
                          () => StaggeredGridView.countBuilder(
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            shrinkWrap: true,
                            itemCount: productController.products.length,
                            itemBuilder: (BuildContext context, int index) {
                              
                              return ProductCard(index: index);
                            },
                            staggeredTileBuilder: (index) {
                              return const StaggeredTile.fit(1);
                            },
                          ),
                        )

                        // Figure out the error asap
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
