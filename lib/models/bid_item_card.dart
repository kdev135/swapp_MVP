import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapp2/components/styles.dart';
import 'package:swapp2/controllers/my_products_controller.dart';

class BidItemCard extends StatefulWidget {
  

  final int cashValue;

  final String image;

  final String category;

  final String name;
  final String id;


  const BidItemCard(
      {required this.name,
      required this.cashValue,
      required this.image,
      required this.category,
      required this.id});

  @override
  State<BidItemCard> createState() => BidItemCardState();
}

class BidItemCardState extends State<BidItemCard> {

  var selectedColor = Colors.lightBlue;
  var cardColor = Colors.grey;
  bool selectionState = false;

  double cardElevation = 1;
  static int totalValue = 0;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectionState = !selectionState;
        });
        (context as Element).markNeedsBuild();
        !selectionState
            ? MyProductsController.selectItems.remove(widget.cashValue)
            : MyProductsController.selectItems.add(widget.cashValue);
        !selectionState
            ? MyProductsController.selectedItemID.remove(widget.id)
            : MyProductsController.selectedItemID.add(widget.id);

        
      },
      child: Card(
        shadowColor: selectionState ? selectedColor : cardColor,
        elevation: selectionState ? 5 : 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              /// 120 for the bid item. smaller for myproducts.
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.image), fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (widget.name),
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
                  Text('Category: ${widget.category}',
                      style: productValueStyle),
                  const SizedBox(
                    height: 10,
                  ),
                  //cash value
                  Text('Cash value: ${widget.cashValue}',
                      style: productValueStyle),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
