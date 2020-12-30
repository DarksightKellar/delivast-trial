import 'package:delivast_trial/resources/constants.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  final Box box;

  HiveHelper(this.box);

  void saveData(String key, Map<String, dynamic> data) {
    box.put(loginKey, data);
  }

  dynamic readData(String key, {dynamic defaultValue}) {
    return box.get(loginKey, defaultValue: defaultValue);
  }

  Future<void> deleteData(String key) async {
    await box.delete(key);
  }
}
