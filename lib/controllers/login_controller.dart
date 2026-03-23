import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/core/widgets/app_widgets.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/views/auth/login_view.dart';
import 'package:movie_app/views/home/home_view.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  GoogleSignInAccount? _googleUser;

  bool isValidEmail(String email) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isLoading(true);
    String? errorMessage;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await pref.setString('email', email.text);
      isLoading(false);
      Get.offAll(() => const HomeView());
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      errorMessage = e.code == 'user-not-found'
          ? 'No user connected with this email'
          : e.code == 'wrong-password'
              ? 'Wrong Password'
              : 'Email or Password Incorrect';
    }
    if (errorMessage != null && context.mounted) {
      showToast(errorMessage, context);
    }
  }

  Future<void> signInWithGoogle() async {
    _googleUser = await GoogleSignIn().signIn();
    final googleAuth = await _googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth.idToken,
    );
    final result = await FirebaseAuth.instance.signInWithCredential(credential);
    await pref.setString('email', result.user!.email.toString());
    await pref.setString('name', result.user!.displayName.toString());
    await pref.setString('image_url', result.user!.photoURL.toString());
    Get.to(() => const HomeView());
  }

  Future<void> logout() async {
    _googleUser = await GoogleSignIn().signOut();
    await pref.clear();
    Get.offAll(() => LoginView());
  }
}
