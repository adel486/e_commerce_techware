import 'dart:ui';

import 'package:e_commerce_techware/controller/login_screen_controller.dart';
import 'package:e_commerce_techware/utils/constants/color_constants.dart';
import 'package:e_commerce_techware/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginScreenController>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://images.pexels.com/photos/27914907/pexels-photo-27914907/free-photo-of-a-woman-in-black-and-white-is-posing-on-a-bridge.jpeg?auto=compress&cs=tinysrgb&w=600',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ColorConstants.mainblack.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ColorConstants.mainwhite.withValues(alpha: 0.3),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.mainwhite,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: userNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorConstants.mainwhite.withValues(
                              alpha: 0.3,
                            ),
                            hintText: 'Enter UserName',
                            hintStyle: TextStyle(
                              color: ColorConstants.mainwhite,
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: ColorConstants.mainwhite,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorConstants.mainwhite.withValues(
                              alpha: 0.3,
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: ColorConstants.mainwhite.withValues(
                                alpha: 0.4,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: ColorConstants.mainwhite.withValues(
                                alpha: 0.4,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Navigate to forgot password screen
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: ColorConstants.mainwhite),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        loginController.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                              onPressed: () async {
                                bool isSuccess = await context
                                    .read<LoginScreenController>()
                                    .login(
                                      userNameController.text,
                                      passwordController.text,
                                    );
                                if (isSuccess) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => HomeScreen(
                                            username: userNameController.text,
                                          ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Invalid username or password",
                                      ),
                                      backgroundColor:
                                          ColorConstants.primaryRed,
                                    ),
                                  );
                                }
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstants.mainwhite
                                    .withValues(alpha: 0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: ColorConstants.mainwhite,
                                ),
                              ),
                            ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                endIndent: 1,
                                indent: 1,
                                color: ColorConstants.mainwhite.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                            Text(
                              'Or',
                              style: TextStyle(
                                color: ColorConstants.mainwhite,
                                fontSize: 17,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                endIndent: 1,
                                indent: 1,
                                color: ColorConstants.mainwhite.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'login with',
                          style: TextStyle(
                            color: ColorConstants.mainwhite,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 10),
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.google,
                            size: 30,
                            color: ColorConstants.mainwhite.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Don't have an account? Sign Up",
                            style: TextStyle(color: ColorConstants.mainwhite),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
