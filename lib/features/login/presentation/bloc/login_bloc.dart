import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:delivast_trial/core/models/user.dart';
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
      yield LoginLoading();

      try {
        final user = await _login(event.email, event.password);
        yield LoginFinished(user);
      } catch (e) {
        yield LoginError(e.message ?? e.toString());
      }
    }
  }

  /// Ideally this would be a Usecase, which would access Dio
  /// through a Repository and Network layer via DI, instead of directly
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
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw Exception("Bad or no internet connection");
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      throw Exception("Something went wrong");
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
