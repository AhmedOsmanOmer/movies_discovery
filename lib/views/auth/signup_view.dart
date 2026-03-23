import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/login_controller.dart';
import 'package:movie_app/controllers/signup_controller.dart';
import 'package:movie_app/core/utils/screen_size.dart';
import 'package:movie_app/core/widgets/app_widgets.dart';
import 'package:movie_app/views/auth/login_view.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final SignUpController controller = Get.put(SignUpController());
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final screen = ScreenSize(context: context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(screen.getHeight() * 0.05),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: screen.fontSize(50), color: Colors.red),
                ),
              ),
              TextFormField(
                controller: controller.name,
                decoration:
                    inputDecoration(const Icon(Icons.person), 'Username'),
                validator: (val) =>
                    val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: controller.email,
                decoration:
                    inputDecoration(const Icon(Icons.email), 'Email'),
                validator: (val) {
                  if (val!.isEmpty) return 'Required';
                  if (!controller.isValidEmail(val)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                obscureText: true,
                controller: controller.password,
                decoration:
                    inputDecoration(const Icon(Icons.password), 'Password'),
                validator: (val) {
                  if (val!.isEmpty) return 'Required';
                  if (val.length < 8) return 'Short Password';
                  return null;
                },
              ),
              TextFormField(
                obscureText: true,
                controller: controller.repassword,
                decoration: inputDecoration(
                    const Icon(Icons.password), 'Confirm Password'),
                validator: (val) {
                  if (val!.isEmpty) return 'Required';
                  if (val.length < 8) return 'Short Password';
                  if (controller.password.text != controller.repassword.text) {
                    return "Passwords don't match";
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: () => controller.signUp(context),
                child: Container(
                  alignment: Alignment.center,
                  height: screen.getHeight() * 0.07,
                  width: screen.getWidth(),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text('Sign Up'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  GestureDetector(
                    onTap: () => Get.to(() => LoginView()),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.red),
                    ),
                  ),
                ],
              ),
              const Text('Or Continue With'),
              GestureDetector(
                onTap: loginController.signInWithGoogle,
                child: Container(
                  width: screen.getWidth() * 0.5,
                  height: screen.getHeight() * 0.08,
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/google.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
