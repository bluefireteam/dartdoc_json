import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('ExtensionDeclaration', () {
    test('simple extension', () {
      expect(
        parseAsJson('''
          extension XX on X {}
        '''),
        {'kind': 'extension', 'name': 'XX', 'on': 'on X'},
      );
    });

    test('extension with comment', () {
      expect(
        parseAsJson('''
          /// Adds shiny new functionality to X
          extension XX on X {}
        '''),
        {
          'kind': 'extension',
          'name': 'XX',
          'on': 'on X',
          'description': 'Adds shiny new functionality to X\n',
        },
      );
    });

    test('extension with members', () {
      expect(
        parseAsJson('''
          extension XX on X {
            int foo() => 3;
            int bar() => -3;
          }
        '''),
        {
          'kind': 'extension',
          'name': 'XX',
          'on': 'on X',
          'members': [
            {'kind': 'method', 'name': 'foo', 'returns': 'int'},
            {'kind': 'method', 'name': 'bar', 'returns': 'int'},
          ],
        },
      );
    });
  });
}
