import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('ExtensionTypeDeclaration', () {
    test('simple extension type', () {
      expect(
        parseAsJson('extension type Meters(int value) {}'),
        {
          'kind': 'extension-type',
          'name': 'Meters',
          'representation': {'name': 'value', 'type': 'int'},
        },
      );
    });

    test('private extension type', () {
      expect(
        parseAsJson('extension type _Meters(int value) {}'),
        isEmpty,
      );
    });

    test('const extension type with named constructor', () {
      expect(
        parseAsJson('extension type const Id.raw(String value) {}'),
        {
          'kind': 'extension-type',
          'name': 'Id',
          'const': true,
          'representation': {
            'name': 'value',
            'type': 'String',
            'constructorName': 'raw',
          },
        },
      );
    });

    test('extension type with implements clause', () {
      expect(
        parseAsJson('extension type Meters(int value) implements num {}'),
        {
          'kind': 'extension-type',
          'name': 'Meters',
          'representation': {'name': 'value', 'type': 'int'},
          'implements': ['num'],
        },
      );
    });

    test('extension type with type parameters', () {
      expect(
        parseAsJson('extension type Box<T>(T value) {}'),
        {
          'kind': 'extension-type',
          'name': 'Box',
          'typeParameters': [
            {'name': 'T'},
          ],
          'representation': {'name': 'value', 'type': 'T'},
        },
      );
    });

    test('extension type with a named constructor', () {
      expect(
        parseAsJson('''
          extension type Meters(int value) {
            Meters.zero() : value = 0;
          }
        '''),
        {
          'kind': 'extension-type',
          'name': 'Meters',
          'representation': {'name': 'value', 'type': 'int'},
          'members': [
            {'kind': 'constructor', 'name': 'Meters.zero'},
          ],
        },
      );
    });

    test('extension type with members and comment', () {
      expect(
        parseAsJson('''
          /// A distance in meters.
          extension type Meters(int value) {
            int get doubled => value * 2;
          }
        '''),
        {
          'kind': 'extension-type',
          'name': 'Meters',
          'representation': {'name': 'value', 'type': 'int'},
          'description': 'A distance in meters.\n',
          'members': [
            {'kind': 'getter', 'name': 'doubled', 'returns': 'int'},
          ],
        },
      );
    });
  });
}
