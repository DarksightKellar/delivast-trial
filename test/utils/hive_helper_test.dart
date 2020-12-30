import 'package:delivast_trial/resources/constants.dart';
import 'package:delivast_trial/utils/hive_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

class MockHiveBox<E> extends Mock implements Box<E> {}

void main() {
  HiveHelper hiveHelper;
  MockHiveBox mockHiveBox;

  final data = {'name': 'Tests'};

  setUpAll(() {
    mockHiveBox = MockHiveBox();
    hiveHelper = HiveHelper(mockHiveBox);

    when(mockHiveBox.get(loginKey)).thenReturn(data);
  });

  test('Save Data', () {
    hiveHelper.saveData(loginKey, data);

    verify(mockHiveBox.put(loginKey, data));
  });

  test('Read Data', () {
    final result = hiveHelper.readData(loginKey);

    verify(mockHiveBox.get(loginKey));
    expect(result, data);
  });

  test('Delete Data', () async {
    await hiveHelper.deleteData(loginKey);

    verify(mockHiveBox.delete(loginKey));
  });
}
