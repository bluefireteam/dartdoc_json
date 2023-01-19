import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('EnumDeclaration', () {
    test('simple enum', () {
      expect(
        parseAsJson('''
          enum A { a }
        '''),
        {
          'kind': 'enum',
          'name': 'A',
          'values': [
            {'name': 'a'},
          ],
        },
      );
    });

    test('enum with doc-comment and annotations', () {
      expect(
        parseAsJson('''
          /// Very important enum!
          @important
          enum A { 
            a,
            b,
            /// third letter
            c,
            /// This constant is private, so shouldn't appear in the output
            _d,
          }
        '''),
        {
          'kind': 'enum',
          'name': 'A',
          'values': [
            {'name': 'a'},
            {'name': 'b'},
            {'name': 'c', 'description': 'third letter\n'},
          ],
          'description': 'Very important enum!\n',
          'annotations': [
            {'name': '@important'},
          ],
        },
      );
    });

    test('enum with parametrized values', () {
      expect(
        parseAsJson('''
          enum Abc { 
            a('one'),
            b('two', 2),
          }
        '''),
        {
          'kind': 'enum',
          'name': 'Abc',
          'values': [
            {
              'name': 'a',
              'arguments': ["'one'"]
            },
            {
              'name': 'b',
              'arguments': ["'two'", '2']
            },
          ],
        },
      );
    });

    test('enum with methods', () {
      expect(
        parseAsJson('''
          enum Abc {
            a;
            
            String makeItFunny() {}
          }
        '''),
        {
          'kind': 'enum',
          'name': 'Abc',
          'values': [
            {'name': 'a'},
          ],
          'members': [
            {'kind': 'method', 'name': 'makeItFunny', 'returns': 'String'},
          ],
        },
      );
    });
  });
}
