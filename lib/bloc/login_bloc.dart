import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivast_trial/models/user.dart';
import 'package:delivast_trial/resources/constants.dart';
import 'package:delivast_trial/utils/hive_helper.dart';
import 'package:delivast_trial/utils/injector.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show required;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is PerformLogin) {
      // Set loading state
      yield LoginLoading();

      // Initiate login
      final user = await _login(event.email, event.password);

      // Trigger login finished state with user
      yield LoginFinished(user);
    }
  }

  Future<User> _login(String email, String password) async {
    final dio = Dio();

    try {
      final response = await dio.get(loginEndpoint);

      if (response.statusCode != 200 || response.data == null) {
        return null;
      }

      final userMap = _parseResponse(response.data);

      // Persist user data
      injector<HiveHelper>().saveData(loginKey, userMap);

      return User.fromMap(userMap);
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> _parseResponse(dynamic data) {
    return {
      'uid': data['results'][0]['login']['uuid'],
      'firstName': data['results'][0]['name']['first'],
      'lastName': data['results'][0]['name']['last'],
      'email': data['results'][0]['email'],
      'password': data['results'][0]['login']['password'],
      'phoneNumber': data['results'][0]['phone'],
      'photoUrl': data['results'][0]['picture']['medium'],
    };
  }
}
