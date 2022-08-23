import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swapp2/screens/catalog_screen.dart';

class SwapRequestScreen extends StatelessWidget {
  const SwapRequestScreen({Key? key}) : super(key: key);
  static List<Widget> myBids = [];
  static List? otherBids = [];

  @override
  Widget build(BuildContext context) {
 
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Get.to(() => CatalogScreen());
            },
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Text('Your bids'),
              ),
              Tab(
                text: 'Otherbids',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            myBids.isEmpty
                ? const Text(
                    'No items here',
                  )
                : Column(
                    children: myBids,
                  ),
            otherBids == null
                ? const Text('No items here')
                : Text(otherBids.toString()),
          ],
        ),
      ),
    );
  }
}
