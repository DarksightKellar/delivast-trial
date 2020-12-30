import 'package:delivast_trial/pages/login.dart';
import 'package:delivast_trial/resources/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              secondary: secondaryColor,
            ),
      ),
      home: LoginPage(),
    );
  }
}
