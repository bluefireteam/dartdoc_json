import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('ClassTypeAlias', () {
    test('simple class type alias', () {
      expect(
        parseAsJson('class C = B with M;'),
        {
          'kind': 'class',
          'name': 'C',
          'extends': 'B',
          'with': ['M'],
        },
      );
    });

    test('private class type alias', () {
      expect(
        parseAsJson('class _C = B with M;'),
        isEmpty,
      );
    });

    test('class type alias with implements and modifiers', () {
      expect(
        parseAsJson('abstract class C = B with M, N implements I;'),
        {
          'kind': 'class',
          'name': 'C',
          'abstract': true,
          'extends': 'B',
          'with': ['M', 'N'],
          'implements': ['I'],
        },
      );
    });

    test('class type alias with type parameters', () {
      expect(
        parseAsJson('class C<T> = B<T> with M<T>;'),
        {
          'kind': 'class',
          'name': 'C',
          'typeParameters': [
            {'name': 'T'},
          ],
          'extends': 'B<T>',
          'with': ['M<T>'],
        },
      );
    });
  });
}
