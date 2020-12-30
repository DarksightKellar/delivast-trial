import 'package:delivast_trial/utils/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validate Email: ', () {
    test('valid email', () {
      expect(Validator.validateEmail('dev@gmail.com'), true);
    });

    test('invalid email', () {
      expect(Validator.validateEmail('g.com'), false);
    });
  });
  group('Validate Password: ', () {
    test('valid password', () {
      expect(Validator.validatePassword('asfksdf'), true);
    });

    test('incorrect password', () {
      expect(Validator.validatePassword('abc'), false);
    });
  });
  group('Validate Phone: ', () {
    test('valid phone', () {
      expect(Validator.validatePhone('+233123456789'), true);
    });

    test('incorrect password', () {
      expect(Validator.validatePhone('0241234567'), false);
    });
  });
}
