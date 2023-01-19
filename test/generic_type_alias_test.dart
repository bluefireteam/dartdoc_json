import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('GenericTypeAlias', () {
    test('simple typedef', () {
      expect(
        parseAsJson('typedef A = int;'),
        {'kind': 'typedef', 'name': 'A'},
      );
    });

    test('private typedefs', () {
      expect(
        parseAsJson('''
          typedef _A = int;
          typedef _B = List<double>;
          @internal typedef C = bool;
        '''),
        isEmpty,
      );
    });

    test('typedef with comment', () {
      expect(
        parseAsJson('''
          /// Some description goes here.
          typedef A = int;
        '''),
        {
          'kind': 'typedef',
          'name': 'A',
          'description': 'Some description goes here.\n',
        },
      );
    });

    test('annotated typedef', () {
      expect(
        parseAsJson('''
          @obsolete
          typedef A = int;
        '''),
        {
          'kind': 'typedef',
          'name': 'A',
          'annotations': [
            {'name': '@obsolete'},
          ],
        },
      );
    });

    test('template typedef', () {
      expect(
        parseAsJson('''
          typedef A<T extends Game> = Abc<T>;
        '''),
        {
          'kind': 'typedef',
          'name': 'A',
          'typeParameters': [
            {'name': 'T', 'extends': 'Game'}
          ],
        },
      );
    });
  });
}
