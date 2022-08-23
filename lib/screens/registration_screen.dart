import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swapp2/components/constants.dart';
import 'package:swapp2/components/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swapp2/components/validators.dart';
import 'package:swapp2/screens/catalog_screen.dart';
import 'package:swapp2/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  late String password2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(child: swappLogo),
                //  SizedBox(height: 100,)
                const SizedBox(
                  height: 80,
                ),
                Text('REGISTER',
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: watermarkStyle),
                const SizedBox(height: 10),
                TextFormField(
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputDecoration.copyWith(
                      label: const Text('Email'), hintText: 'Enter your Email'),
                  onChanged: (String value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: validatePassword,
                  scrollPadding: const EdgeInsets.all(10),
                  obscureText: true,
                  decoration: inputDecoration.copyWith(
                      label: const Text('Password'),
                      hintText: 'Enter your password'),
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (password.isEmpty || email.isEmpty) {
                        Get.snackbar('Something is not right',
                            'Both password and email are required.', snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 3));
                      } else {
                        try {
                          final UserCredential? newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            Get.to(() => CatalogScreen());
                          }
                        } on FirebaseException catch (err) {
                          Get.snackbar('Error!', '${err.message},',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 3));
                        }
                      }
                    },
                    child: const Text('Register')),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Have an account? '),
                    GestureDetector(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.lightBlue,
                        ),
                      ),
                      onTap: () => Get.to(() => const LoginScreen()),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
