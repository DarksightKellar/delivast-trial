import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:delivast_trial/core/models/user.dart';
import 'package:delivast_trial/resources/colors.dart';
import 'package:delivast_trial/resources/constants.dart';
import 'package:delivast_trial/resources/images.dart';
import 'package:delivast_trial/utils/hive_helper.dart';
import 'package:delivast_trial/utils/injector.dart';
import 'package:delivast_trial/utils/validator.dart';
import 'package:delivast_trial/core/widgets/action_button.dart';
import 'package:delivast_trial/core/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../login/presentation/pages/login.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage(this.user);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final lastNameFocus = FocusNode();
  final emailAddressFocus = FocusNode();
  final passwordFocus = FocusNode();
  final phoneNumberFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String cCode = '+233';

  String fieldValidator(String value, String message) {
    return value.isEmpty ? message : null;
  }

  @override
  void initState() {
    super.initState();
  }

  void _onCountryPicked(Country country) {
    setState(() {
      cCode = '+${country.phoneCode}';
    });

    _formKey.currentState.validate();
  }

  @override
  void dispose() {
    lastNameFocus.dispose();
    emailAddressFocus.dispose();
    passwordFocus.dispose();
    phoneNumberFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const space = 28.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          color: primaryColor,
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Image.asset(logoText, height: 25),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 24),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.user.photoUrl),
                  radius: 45,
                ),
                SizedBox(height: 12),
                Text(
                  '${widget.user.firstName} ${widget.user.lastName}',
                  style: TextStyle(
                    color: textColor.withOpacity(0.9),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 24),
                Divider(indent: 50, endIndent: 50),
                SizedBox(height: 24),
                InputField(
                  hint: 'First name',
                  value: widget.user.firstName,
                  contentPadding: contentPadding,
                  margin: margin,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => lastNameFocus.requestFocus(),
                  validator: (value) => fieldValidator(value, firstNameError),
                ),
                SizedBox(height: space),
                InputField(
                  hint: 'Last name',
                  focusNode: lastNameFocus,
                  value: widget.user.lastName,
                  contentPadding: contentPadding,
                  margin: margin,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => emailAddressFocus.requestFocus(),
                  validator: (value) => fieldValidator(value, lastNameError),
                ),
                SizedBox(height: space),
                InputField(
                  hint: 'Email',
                  focusNode: emailAddressFocus,
                  value: widget.user.email,
                  contentPadding: contentPadding,
                  margin: margin,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
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
                SizedBox(height: space),
                InputField(
                  hint: 'Password',
                  focusNode: passwordFocus,
                  value: widget.user.password,
                  contentPadding: contentPadding,
                  margin: margin,
                  isPassword: true,
                  suffixText: 'Change',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  onEditingComplete: () => phoneNumberFocus.requestFocus(),
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
                SizedBox(height: space),
                InputField(
                  hint: 'Phone',
                  autovalidateMode: AutovalidateMode.always,
                  focusNode: phoneNumberFocus,
                  value: widget.user.phoneNumber,
                  contentPadding: contentPadding,
                  margin: margin,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    if ((cCode + value).isEmpty) {
                      return emptyPhoneError;
                    } else if (Validator.validatePhone(cCode + value)) {
                      return null;
                    } else {
                      return phoneError;
                    }
                  },
                  prefix: CountryPickerDropdown(
                    initialValue: 'GH',
                    itemBuilder: (Country country) {
                      return Container(
                        height: 48,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 8),
                            CountryPickerUtils.getDefaultFlagImage(country),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                "+${country.phoneCode}",
                                style: TextStyle(
                                  color: textColor.withOpacity(0.9),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onValuePicked: _onCountryPicked,
                  ),
                ),
                SizedBox(height: 56),
                ActionButton(
                  label: Text(
                    'Save changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {},
                  minimumSize: Size(180, 40),
                ),
                SizedBox(height: space),
                Divider(),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () async => _performLogout(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(logoutIcon, height: 30),
                      SizedBox(width: 56),
                      Text(
                        'Log out',
                        style: TextStyle(
                          color: redColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _performLogout(BuildContext context) async {
    FocusScope.of(context).unfocus();

    await injector<HiveHelper>().deleteData(loginKey);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }
}
