import 'package:test/test.dart';
import 'utils.dart';

void main() {
  group('ClassDeclaration', () {
    test('bare class', () {
        expect(
        parseAsJson('class X {}'),
        {'kind': 'class', 'name': 'X'},
      );
    });

    test('private classes', () {
      expect(
        parseAsJson('''
          class _X {}
          
          @internal
          class Y {}
          
          @visibleForTesting
          class Z {}
        '''),
        isEmpty,
      );
    });

    test('abstract class', () {
      expect(
        parseAsJson('abstract class X {}'),
        {'kind': 'class', 'name': 'X', 'abstract': true},
      );
    });

    test('template class 1', () {
      expect(
        parseAsJson('class X<T extends Base> {}'),
        {
          'kind': 'class',
          'name': 'X',
          'typeParameters': [
            {'name': 'T', 'extends': 'Base'}
          ]
        },
      );
    });

    test('template class 2', () {
      expect(
        parseAsJson('class Xyz<T extends A<B>, S extends Base2, R> {}'),
        {
          'kind': 'class',
          'name': 'Xyz',
          'typeParameters': [
            {'name': 'T', 'extends': 'A<B>'},
            {'name': 'S', 'extends': 'Base2'},
            {'name': 'R'},
          ]
        },
      );
    });

    test('class extends', () {
      expect(
        parseAsJson('class X extends A<X> {}'),
        {
          'kind': 'class',
          'name': 'X',
          'extends': 'A<X>',
        },
      );
    });

    test('class implements', () {
      expect(
        parseAsJson('class X implements A<X>, B {}'),
        {
          'kind': 'class',
          'name': 'X',
          'implements': ['A<X>', 'B'],
        },
      );
    });

    test('class with', () {
      expect(
        parseAsJson('class X with A, B, C<D<E>> {}'),
        {
          'kind': 'class',
          'name': 'X',
          'with': ['A', 'B', 'C<D<E>>'],
        },
      );
    });

    test('class annotations', () {
      expect(
        parseAsJson(
          '''
          @external
          @Deprecated('will be removed when hell freezes over')
          class X {}
          ''',
        ),
        {
          'kind': 'class',
          'name': 'X',
          'annotations': [
            {'name': '@external'},
            {
              'name': '@Deprecated',
              'arguments': ["'will be removed when hell freezes over'"],
            },
          ],
        },
      );
    });

    test('class comment', () {
      expect(
        parseAsJson(
          '''
          /// This is a class doc-comment
          ///
          /// More lines
          ///    ...example
          class X {}
          ''',
        ),
        {
          'kind': 'class',
          'name': 'X',
          'description': 'This is a class doc-comment\n'
              '\n'
              'More lines\n'
              '   ...example\n',
        },
      );
    });

    test('class non-comment', () {
      expect(
        parseAsJson(
          '''
          // This is not a class doc-comment
          class X {}
          ''',
        ),
        {'kind': 'class', 'name': 'X'},
      );
    });

    test('class mixed comments', () {
      expect(
        parseAsJson(
          '''
          /// This is a class doc-comment
          ///------
          //
          // (not a comment)
          class X {}
          ''',
        ),
        {
          'kind': 'class',
          'name': 'X',
          'description': 'This is a class doc-comment\n------\n',
        },
      );
    });
  });
}
