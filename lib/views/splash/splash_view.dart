import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/views/auth/login_view.dart';
import 'package:movie_app/views/home/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() =>
          pref.getString('email') != null ? const HomeView() : LoginView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/logo.png')),
    );
  }
}
