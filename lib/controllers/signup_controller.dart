import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/widgets/app_widgets.dart';
import 'package:movie_app/views/auth/login_view.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController repassword = TextEditingController();

  bool isValidEmail(String email) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  Future<void> _storeUserData(String id) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': name.text,
      'email': email.text,
    });
  }

  Future<void> signUp(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    String? successMessage;
    String? errorMessage;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await _storeUserData(credential.user!.uid);
      Get.to(() => LoginView());
      successMessage = 'Sign Up successful — Login now';
    } on FirebaseAuthException catch (e) {
      errorMessage = e.code == 'weak-password'
          ? 'Weak Password'
          : e.code == 'email-already-in-use'
              ? 'Email already exists'
              : 'Sign Up failed';
    }
    if (context.mounted) {
      if (successMessage != null) showToast(successMessage, context);
      if (errorMessage != null) showToast(errorMessage, context);
    }
    update();
  }
}
