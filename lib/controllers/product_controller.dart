import 'package:get/get.dart';
import 'package:swapp2/models/product_model.dart';
import 'package:swapp2/services/firestore_db.dart';

// initialize a stream of  products from firebase
class ProductController extends GetxController with StateMixin<Product>{
  final products = <Product>[].obs;
  @override
 
  @override
  void onInit() {
  
      products.bindStream(FirestoreDB().getAllProducts());

    super.onInit();
  }
}
