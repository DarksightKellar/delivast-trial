import 'package:delivast_trial/pages/splash_screen.dart';
import 'package:delivast_trial/resources/colors.dart';
import 'package:delivast_trial/utils/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';

void main() async {
  await setupInjector();
  runApp(DelivastApp());
}

class DelivastApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: MaterialApp(
        title: 'Delivast',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: secondaryColor,
              ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
