import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/login_controller.dart';
import 'package:movie_app/core/utils/screen_size.dart';
import 'package:movie_app/core/widgets/app_widgets.dart';
import 'package:movie_app/views/auth/signup_view.dart';
import 'package:movie_app/views/home/home_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final screen = ScreenSize(context: context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => controller.isLoading.value
              ? showLoading()
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screen.getHeight() * 0.04,
                    vertical: screen.getHeight() * 0.07,
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: screen.getWidth() * 0.2,
                          backgroundImage: const AssetImage('assets/logo.png'),
                        ),
                        SizedBox(height: screen.getHeight() * 0.05),
                        TextFormField(
                          onTapOutside: (_) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          controller: controller.email,
                          decoration:
                              inputDecoration(const Icon(Icons.email), 'Email'),
                          validator: (val) {
                            if (val!.isEmpty) return 'Required';
                            if (!controller.isValidEmail(val)) {
                              return 'Enter a valid Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: screen.getHeight() * 0.03),
                        TextFormField(
                          onTapOutside: (_) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          obscureText: true,
                          controller: controller.password,
                          decoration: inputDecoration(
                              const Icon(Icons.password), 'Password'),
                          validator: (val) {
                            if (val!.isEmpty) return 'Required';
                            if (val.length < 8) return 'Short Password';
                            return null;
                          },
                        ),
                        SizedBox(height: screen.getHeight() * 0.03),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forget My Password',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.red),
                          ),
                        ),
                        SizedBox(height: screen.getHeight() * 0.03),
                        GestureDetector(
                          onTap: () => controller.login(context),
                          child: Container(
                            alignment: Alignment.center,
                            height: screen.getHeight() * 0.06,
                            width: screen.getWidth(),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text('Login',
                                style:
                                    TextStyle(fontSize: screen.fontSize(25))),
                          ),
                        ),
                        SizedBox(height: screen.getHeight() * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () => Get.to(() => SignUpView()),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screen.getHeight() * 0.05),
                        InkWell(
                          onTap: () => Get.to(() => const HomeView()),
                          child: const Text(
                            'Continue as a Guest',
                            style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        SizedBox(height: screen.getHeight() * 0.07),
                        const Text('Or Continue With'),
                        const SizedBox(height: 50),
                        GestureDetector(
                          onTap: controller.signInWithGoogle,
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
        ),
      ),
    );
  }
}
