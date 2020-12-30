import 'package:delivast_trial/bloc/login_bloc.dart';
import 'package:delivast_trial/resources/colors.dart';
import 'package:delivast_trial/resources/constants.dart';
import 'package:delivast_trial/resources/images.dart';
import 'package:delivast_trial/utils/validator.dart';
import 'package:delivast_trial/widgets/action_button.dart';
import 'package:delivast_trial/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final passwordFocus = FocusNode();

  bool isLoading = false;

  void _login() {
    FocusScope.of(context).unfocus();
    _formKey.currentState.save();

    if (_formKey.currentState.validate()) {
      BlocProvider.of<LoginBloc>(context).add(
        PerformLogin(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    passwordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (_, state) {
            if (mounted) {
              setState(() {
                isLoading = state is LoginLoading;
              });
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 72),
                  Image.asset(logoText, height: 25),
                  SizedBox(height: 32),
                  Text(
                    'Log in as Shopper or Driver',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 32),
                  InputField(
                    controller: emailController,
                    hint: 'Email address',
                    contentPadding: contentPadding,
                    margin: margin,
                    enabled: !isLoading,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => passwordFocus.requestFocus(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return emptyEmailError;
                      } else if (Validator.validateEmail(value)) {
                        return null;
                      } else {
                        return emailError;
                      }
                    },
                  ),
                  SizedBox(height: 32),
                  InputField(
                    controller: passwordController,
                    hint: 'Password',
                    suffixText: 'Forgot password?',
                    contentPadding: contentPadding,
                    margin: margin,
                    isPassword: true,
                    focusNode: passwordFocus,
                    keyboardType: TextInputType.visiblePassword,
                    enabled: !isLoading,
                    onEditingComplete: _login,
                    validator: (value) {
                      if (value.isEmpty) {
                        return emptyPasswordError;
                      } else if (Validator.validatePassword(value)) {
                        return null;
                      } else {
                        return passwordError;
                      }
                    },
                  ),
                  SizedBox(height: 40),
                  ActionButton(
                    label: isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              backgroundColor: Colors.white,
                            ),
                          )
                        : Text(
                            'Log in',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    onPressed: _login,
                    minimumSize: Size(180, 40),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Don't have an account?\nSign up to become part of us",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor, height: 2),
                  ),
                  SizedBox(height: 32),
                  ActionButton(
                    label: Text(
                      'Join Delivast',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    margin: margin,
                    borderSide: BorderSide(color: primaryColor, width: 1.3),
                    minimumSize: Size(double.maxFinite, 40),
                  ),
                  SizedBox(height: 48),
                  Image.asset(
                    loginBottomImage,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
