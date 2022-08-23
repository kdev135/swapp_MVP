import 'package:flutter/material.dart';
import 'package:swapp2/components/styles.dart';
import 'package:swapp2/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:swapp2/screens/product_info_screen.dart';

// Model for the card widget of each product to use in catalog

class ProductCard extends StatelessWidget {
  final ProductController productController = Get.find();
  final int index;

  ProductCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductInfoScreen(), arguments: [
          productController.products[index].image,
          productController.products[index].label,
          productController.products[index].details,
          productController.products[index].value,
          productController.products[index].category,
          productController.products[index].owner,
        ]);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                productController.products[index].image,
                scale: 2,
                fit: BoxFit.scaleDown,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                   
                    return child;
                  } else if (loadingProgress.expectedTotalBytes != null) {
                   
                    return const CircularProgressIndicator();
                  }
                  return const Placeholder();
                },
              ),

              const SizedBox(height: 5),
              // Name of the product
              Text(
                productController.products[index].label.toString(),
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: productlabelStyle,
              ),
              const SizedBox(height: 3),
              // Estimated value of the product
              Text('Ksh. ${productController.products[index].value.toString()}',
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: productValueStyle),
            ],
          ),
        ),
      ),
    );
  }
}
