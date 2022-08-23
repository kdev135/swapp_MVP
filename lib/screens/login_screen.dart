import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swapp2/components/constants.dart';
import 'package:swapp2/components/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swapp2/screens/catalog_screen.dart';
import 'package:swapp2/components/validators.dart';
import 'package:swapp2/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  String? errorMessage;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        swappLogo,
        const SizedBox(
          height: 80,
        ),
        Text('Login',
            overflow: TextOverflow.fade,
            softWrap: false,
            style: watermarkStyle),
        const SizedBox(height: 10),
        TextFormField(
          autovalidateMode: AutovalidateMode.always,
          validator: validateEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: inputDecoration.copyWith(
              label: const Text('Email'), hintText: 'Enter your Email'),
          onChanged: (String value) => email = value,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          validator: validatePassword,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          decoration: inputDecoration.copyWith(
              label: const Text('password'),
              hintText: 'Enter your password'),
          onChanged: (String value) => password = value,
        ),
        const SizedBox(
          height: 50,
        ),
        ElevatedButton(
          child: const Text('Login'),
          onPressed: () async {
            if (password.isEmpty || email.isEmpty) {
              Get.snackbar('Something is not right',
                  'Both password and email are required.',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 3));
            } else {
              try {
                final UserCredential? loggedinuser =
                    await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                if (loggedinuser != null) {
                  Get.to(() => CatalogScreen());
                }
              } on FirebaseException catch (err) {
                // ignore: avoid_print
                errorMessage = err.code;
                printError(info: err.code);
                Get.snackbar(
                  'Something is not right',
                  err.code,
                  duration: const Duration(seconds: 3),
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Got no account? '),
            GestureDetector(
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.lightBlue),
              ),
              onTap: () {
                Get.to(() => const RegistrationScreen());
              },
            ),
          ],
        ),
        const SizedBox(
          height: 100,
        ),
        Visibility(
            visible:
                errorMessage == 'network-request-failed' ? true : false,
            child: const ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: Icon(
                Icons.warning_amber,
                color: Colors.amber,
              ),
              title: Text('Check your internet connection.'),
            ))
      ],
        ),
      ),
    );
  }
}
