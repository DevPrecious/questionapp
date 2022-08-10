// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qapp/controllers/AuthController.dart';
import 'package:qapp/views/login.dart';
import 'package:qapp/views/widgets/custom_button.dart';
import 'package:qapp/views/widgets/custom_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            'Create Account',
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
                  label: 'Name',
                  controller: _nameController,
                ),
                SizedBox(
                  height: 25,
                ),
                CustomInput(
                  label: 'Username',
                  controller: _usernameController,
                ),
                SizedBox(
                  height: 25,
                ),
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
                _authController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      )
                    : CustomButton(
                        onPressed: () {
                          _authController.RegisterUser(
                            email: _emailController.text,
                            password: _passwordController.text,
                            name: _nameController.text,
                            username: _usernameController.text,
                          );
                        },
                        text: 'Register',
                      ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (() => Get.to(() => LoginPage())),
                  child: Text(
                    'Already have an account? Sign in',
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
