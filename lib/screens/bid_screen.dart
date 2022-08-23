import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapp2/components/constants.dart';
import 'package:swapp2/components/styles.dart';
import 'package:swapp2/controllers/my_products_controller.dart';
import 'package:swapp2/models/bid_item_card.dart';
import 'package:swapp2/screens/swap_requests_screen.dart';

class BidScreen extends StatefulWidget {
  const BidScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BidScreen> createState() => _BidScreenState();
}

class _BidScreenState extends State<BidScreen> {
  /// image, label, details, value, category
  final List prod = Get.arguments;

  String _choice = '';

  Widget paymentWidget = const Center(
    child: Text('You have not selected a swap method.'),
  );

  late int totalValue;
  Text checkoutMessage = const Text('');

  final List _choices = ['Item', 'Cash', 'Item + Cash'];
  final key = GlobalKey<BidItemCardState>();
  int amount = BidItemCardState.totalValue;

  GetBuilder<MyProductsController> myItems = GetBuilder<MyProductsController>(
    init: MyProductsController(),
    builder: (val) => Column(children: val.itemList),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
           iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white.withOpacity(0),
        ),
        body: Padding(
          padding: kContentPadding,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      /// 120 for the bid item. smaller for myproducts.
                      height: 100,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              prod[0].toString(),
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            prod[1],
                            style: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            softWrap: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // category
                          Text('Category: ${prod[4]}',
                              style: productValueStyle),
                          const SizedBox(
                            height: 10,
                          ),
                          //cash value
                          Text('Cash value: ${prod[3]}',
                              style: productValueStyle),
                        ],
                      ),
                    )
                  ],
                ),
              ),
             
              const SizedBox(
                height: 20,
              ),
              Text(
                'select your swap method',
                style: titleStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChoiceChip(
                    selectedColor: kSelectedChipColor,
                    labelStyle: chipTextStyle,
                    label: Text(_choices[0]),
                    selected: _choice == _choices[0] ? true : false,
                    onSelected: (bool selected) {
                      selected ? _choice = _choices[0] : _choice = '';
                      selected
                          ? paymentWidget = myItems
                          : paymentWidget = const Text(
                              'You have not selected a swap method.');

                      (context as Element).markNeedsBuild();
                    },
                  ),
                  ChoiceChip(
                    selectedColor: kSelectedChipColor,
                    labelStyle: chipTextStyle,
                    label: Text(_choices[1]),
                    selected: _choice == _choices[1] ? true : false,
                    onSelected: (bool selected) {
                      _choice = _choices[1];
                      MyProductsController.selectItems.clear();
                      paymentWidget = Center(
                        child: Text(
                            'You have selected to pay Ksh. ${prod[3]} in cash for the item.'),
                      );
                      setState(() {
                        checkoutMessage = Text(
                            'You have choosen to pay Ksh. ${prod[3]} for the item.Propose the swap?');
                      });

                      (context as Element).markNeedsBuild();
                    },
                  ),
                  ChoiceChip(
                    selectedColor: kSelectedChipColor,
                    labelStyle: chipTextStyle,
                    label: Text(_choices[2]),
                    selected: _choice == _choices[2] ? true : false,
                    onSelected: (bool selected) {
                      MyProductsController.selectItems.clear();
                      _choice = _choices[2];
                      paymentWidget =
                          const Center(child: Text('choose item and cash'));
                      setState(() {
                        checkoutMessage = Text(
                            'You have selected cash and ${MyProductsController.selectItems.length} of your items.Propose the swap?');
                      });

                      (context as Element).markNeedsBuild();
                    },
                  ),
                  const SizedBox(
                    width: 05,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            paymentWidget
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Visibility(
            visible: _choice == '' ? false : true,
            child: ElevatedButton(
                // Finish buttom
                onPressed: () {
                  // print('$selectedItems');
                  if (_choice == 'Item' &&
                      MyProductsController.selectItems.isEmpty) {
                    Get.snackbar('Select an item',
                        'You have not selected any items yet.',
                        duration: const Duration(seconds: 3),
                        snackPosition: SnackPosition.BOTTOM);
                  } else {
                    showAlert(context);
                  }
                },
                child: const Text('Finish')),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Place bid?'),
            content: _choice == _choices[0]
                ? Text(
                    'You have selected ${MyProductsController.selectItems.length} of your products. Propose swap?')
                : checkoutMessage,
            actions: [
              GestureDetector(
                  onTap: () {
                    SwapRequestScreen.myBids.add(
                      Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              /// 120 for the bid item. smaller for myproducts.
                              height: 100,
                              width: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      prod[0].toString(),
                                    ),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    prod[1],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                    softWrap: true,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // category
                                  Text('Category: ${prod[4]}',
                                      style: productValueStyle),
                                  //cash value
                                  Text('Cash value: ${prod[3]}',
                                      style: productValueStyle),
                                       Text('Swap method: $_choice',
                                      style: productValueStyle),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );

                    Get.to(() => const SwapRequestScreen(), arguments: prod);
                  },
                  child: const Text('Yes',
                      style: TextStyle(color: Colors.lightBlue))),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child:
                    const Text('No', style: TextStyle(color: Colors.lightBlue)),
              ),
            ],
          );
        });
  }
}
