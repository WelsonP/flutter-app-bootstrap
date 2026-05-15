import 'package:flutter_test/flutter_test.dart';

import '../../../lib/core/validators/validators.dart';

void main() {
  group('Validators', () {
    group('required', () {
      test('should return error for null', () {
        expect(Validators.required(null), isNotNull);
      });

      test('should return error for empty string', () {
        expect(Validators.required(''), isNotNull);
      });

      test('should return error for whitespace only', () {
        expect(Validators.required('   '), isNotNull);
      });

      test('should return null for valid string', () {
        expect(Validators.required('hello'), isNull);
      });
    });

    group('email', () {
      test('should return error for null', () {
        expect(Validators.email(null), isNotNull);
      });

      test('should return error for empty string', () {
        expect(Validators.email(''), isNotNull);
      });

      test('should return error for invalid email', () {
        expect(Validators.email('not-an-email'), isNotNull);
        expect(Validators.email('test@'), isNotNull);
        expect(Validators.email('@test.com'), isNotNull);
      });

      test('should return null for valid email', () {
        expect(Validators.email('test@example.com'), isNull);
        expect(Validators.email('user.name@domain.co'), isNull);
      });
    });

    group('password', () {
      test('should return error for null', () {
        expect(Validators.password(null), isNotNull);
      });

      test('should return error for empty string', () {
        expect(Validators.password(''), isNotNull);
      });

      test('should return error for short password', () {
        expect(Validators.password('1234567'), isNotNull);
      });

      test('should return null for valid password', () {
        expect(Validators.password('12345678'), isNull);
        expect(Validators.password('strongpass'), isNull);
      });
    });

    group('confirmPassword', () {
      test('should return error for null', () {
        final validator = Validators.confirmPassword('password');
        expect(validator(null), isNotNull);
      });

      test('should return error for empty string', () {
        final validator = Validators.confirmPassword('password');
        expect(validator(''), isNotNull);
      });

      test('should return error for mismatched passwords', () {
        final validator = Validators.confirmPassword('password');
        expect(validator('different'), isNotNull);
      });

      test('should return null for matching passwords', () {
        final validator = Validators.confirmPassword('password');
        expect(validator('password'), isNull);
      });
    });
  });
}
