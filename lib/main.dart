import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swapp2/screens/login_screen.dart';
import 'screens/catalog_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Swapp2());
}

class Swapp2 extends StatelessWidget {
  
  final _auth = FirebaseAuth.instance;

  Swapp2({Key? key}) : super(key: key);
  


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:_auth.currentUser != null ? CatalogScreen() : const LoginScreen(),
    );
  }
}
