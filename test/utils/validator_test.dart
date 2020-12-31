import 'package:delivast_trial/utils/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validate Email: ', () {
    test('valid email', () {
      expect(Validator.validateEmail('dev@gmail.com'), true);
      expect(Validator.validateEmail('dev@gmail.co'), true);
      expect(Validator.validateEmail('senior123.dev@app.co'), true);
    });

    test('invalid email', () {
      expect(Validator.validateEmail('g.com'), false);
      expect(Validator.validateEmail('123'), false);
      expect(Validator.validateEmail('g.c'), false);
      expect(Validator.validateEmail('developer.com'), false);
      expect(Validator.validateEmail('.com'), false);
      expect(Validator.validateEmail('someone.'), false);
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
      expect(Validator.validatePhone('+1-202-555-0189'), true);
      expect(Validator.validatePhone('+44 1632 960435'), true);
      expect(Validator.validatePhone('+61 1900 654 321'), true);
      expect(Validator.validatePhone('+27 81 697 5229'), true);
    });

    test('incorrect password', () {
      expect(Validator.validatePhone('0241234567'), false);
      expect(Validator.validatePhone('123456'), false);
      expect(Validator.validatePhone('(123)-456-789'), false);
      expect(Validator.validatePhone('202-555-0121'), false);
      expect(Validator.validatePhone('81 697 5229'), false);
    });
  });
}
