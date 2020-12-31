import 'package:delivast_trial/models/user.dart';
import 'package:delivast_trial/pages/profile.dart';
import 'package:delivast_trial/resources/constants.dart';
import 'package:delivast_trial/resources/images.dart';
import 'package:delivast_trial/utils/hive_helper.dart';
import 'package:delivast_trial/utils/injector.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SplashScreen extends StatelessWidget {
  Future<User> init() async {
    // Check for previous auth
    final userMap = injector<HiveHelper>().readData(loginKey);

    await Future.delayed(Duration(seconds: 1));

    if (userMap != null) {
      return User.fromMap(Map<String, dynamic>.from(userMap));
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: Image.asset(logoText, width: 250),
            );
          } else if (snapshot.data != null) {
            return ProfilePage(snapshot.data);
          }

          return LoginPage();
        },
      ),
    );
  }
}
