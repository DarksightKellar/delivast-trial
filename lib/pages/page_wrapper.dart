import 'package:delivast_trial/bloc/login_bloc.dart';
import 'package:delivast_trial/pages/login.dart';
import 'package:delivast_trial/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageWrapper extends StatefulWidget {
  @override
  _PageWrapperState createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  final loginBloc = LoginBloc();

  @override
  void dispose() {
    loginBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: BlocBuilder<LoginBloc, LoginState>(
        cubit: loginBloc,
        builder: (context, loginState) {
          if (loginState is LoginFinished && loginState.user != null) {
            return ProfilePage(loginState.user);
          }

          return LoginPage();
        },
      ),
    );
  }
}
