// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qapp/controllers/AuthController.dart';
import 'package:qapp/views/register.dart';
import 'package:qapp/views/widgets/custom_button.dart';
import 'package:qapp/views/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            'Login Into Your Account',
            style: GoogleFonts.workSans(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomInput(
                  label: 'Email',
                  controller: _emailController,
                ),
                SizedBox(
                  height: 25,
                ),
                CustomInput(
                  label: 'Password',
                  controller: _passwordController,
                  isObscure: true,
                ),
                SizedBox(
                  height: 25,
                ),
                Obx(() {
                  return _authController.isLoading.value
                      ? Center(
                          child: Text(
                            'Processing...',
                            style: GoogleFonts.workSans(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : CustomButton(
                          onPressed: () {
                            _authController.LoginUser(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );
                          },
                          text: 'Login',
                        );
                }),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (() => Get.to(() => RegisterPage())),
                  child: Text(
                    'Dont have an account? Sign up',
                    style: GoogleFonts.workSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
