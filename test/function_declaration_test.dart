import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('FunctionDeclaration', () {
    test('simple function', () {
      expect(
        parseAsJson('''
          void foo(int a, int b) {}
        '''),
        {
          'kind': 'function',
          'name': 'foo',
          'returns': 'void',
          'parameters': {
            'all': [
              {'name': 'a', 'type': 'int'},
              {'name': 'b', 'type': 'int'},
            ]
          },
        },
      );
    });

    test('private functions', () {
      expect(
        parseAsJson('''
          void _foo(int a, int b) {}
          
          @internal
          void bar() {}
        '''),
        isEmpty,
      );
    });

    test('function with all features', () {
      expect(
        parseAsJson('''
          /// Moos at the given [volume].
          @sensitive
          void moo<T>([double volume = 1.0]) {}
        '''),
        {
          'kind': 'function',
          'name': 'moo',
          'returns': 'void',
          'typeParameters': [
            {'name': 'T'}
          ],
          'parameters': {
            'all': [
              {'name': 'volume', 'type': 'double', 'default': '1.0'},
            ],
            'positional': 1,
          },
          'description': 'Moos at the given [volume].\n',
          'annotations': [
            {'name': '@sensitive'},
          ],
        },
      );
    });
  });
}
