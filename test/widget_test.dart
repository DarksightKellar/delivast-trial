import 'package:delivast_trial/bloc/login_bloc.dart';
import 'package:delivast_trial/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Simple widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => LoginBloc(),
          child: LoginPage(),
        ),
      ),
    );

    expect(find.byType(LoginPage), findsOneWidget);
  });
}
