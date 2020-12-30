import 'package:delivast_trial/resources/constants.dart';
import 'package:delivast_trial/utils/hive_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final injector = GetIt.instance;

void setupInjector() {
  injector.registerLazySingleton(() => HiveHelper(Hive.box(delivastBox)));
}
