import 'package:delivast_trial/models/user.dart';
import 'package:delivast_trial/pages/page_wrapper.dart';
import 'package:delivast_trial/pages/profile.dart';
import 'package:delivast_trial/resources/constants.dart';
import 'package:delivast_trial/resources/images.dart';
import 'package:delivast_trial/utils/hive_helper.dart';
import 'package:delivast_trial/utils/injector.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreen extends StatelessWidget {
  Future<User> init() async {
    await Hive.initFlutter();
    await Hive.openBox(delivastBox);

    setupInjector();

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
              child: Image.asset(logoText),
            );
          } else if (snapshot.data != null) {
            return ProfilePage(snapshot.data);
          }

          return PageWrapper();
        },
      ),
    );
  }
}
