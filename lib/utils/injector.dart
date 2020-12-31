import 'package:delivast_trial/resources/constants.dart';
import 'package:delivast_trial/utils/hive_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';

final injector = GetIt.instance;

Future<void> setupInjector() async {
  await Hive.initFlutter();
  final box = await Hive.openBox(delivastBox);

  injector.registerLazySingleton(() => HiveHelper(box));
}
