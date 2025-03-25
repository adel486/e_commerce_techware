import 'package:e_commerce_techware/controller/home_screen_controller.dart';
import 'package:e_commerce_techware/controller/login_screen_controller.dart';
import 'package:e_commerce_techware/controller/product_detail_screen_controller.dart';
import 'package:e_commerce_techware/controller/search_screen_controller.dart';
import 'package:e_commerce_techware/view/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginScreenController()),
        ChangeNotifierProvider(create: (context) => HomeScreenController()),
        ChangeNotifierProvider(
          create: (context) => ProductDetailScreenController(),
        ),
        ChangeNotifierProvider(create: (context) => SearchScreenController()),
      ],
      child: MaterialApp(home: LoginScreen()),
    );
  }
}
