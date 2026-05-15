import 'package:flutter_test/flutter_test.dart';

import '../../../lib/core/errors/app_exception.dart';

void main() {
  group('AppException', () {
    test('should store message and optional code', () {
      const exception = NetworkException(
        'Connection failed',
        code: 'NET_001',
        statusCode: 500,
      );

      expect(exception.message, 'Connection failed');
      expect(exception.code, 'NET_001');
      expect(exception.statusCode, 500);
    });

    test('localizedMessage should return message', () {
      const exception = AuthException('Auth failed');

      expect(exception.localizedMessage, 'Auth failed');
    });

    test('toString should include message and code', () {
      const exception = ValidationException('Invalid input', code: 'VAL_001');

      expect(
        exception.toString(),
        contains('Invalid input'),
      );
      expect(exception.toString(), contains('VAL_001'));
    });

    test('NetworkException should store status code', () {
      const exception = NetworkException('Not found', statusCode: 404);

      expect(exception.statusCode, 404);
    });

    test('AuthException should be an AppException', () {
      const exception = AuthException('Unauthorized');

      expect(exception, isA<AppException>());
    });

    test('ValidationException should be an AppException', () {
      const exception = ValidationException('Required field');

      expect(exception, isA<AppException>());
    });
  });
}
