import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('TopLevelVariableDeclaration', () {
    test('simple variable', () {
      expect(
        parseAsJson('const int w = 1;'),
        {
          'kind': 'variable',
          'name': 'w',
          'type': 'int',
          'const': true,
        },
      );
    });

    test('hidden variables', () {
      expect(
        parseAsJson('''
          int _x = 1;
          @internal int y = 2;
          @visibleForTesting int z = 0;
        '''),
        isEmpty,
      );
    });

    test('multiple variables in a single declaration', () {
      expect(
        parseAsJson('''
          /// Letters
          late final int a, b, c;
        '''),
        {
          'kind': 'variable',
          'name': 'a',
          'extraNames': ['b', 'c'],
          'type': 'int',
          'description': 'Letters\n',
          'late': true,
          'final': true,
        },
      );
    });
  });
}
