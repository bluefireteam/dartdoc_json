import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('MethodDeclaration', () {
    test('simple method', () {
      expect(
        parseMethods('''
          abstract class X {
            void foo();
          }
        '''),
        [
          {'kind': 'method', 'name': 'foo', 'returns': 'void'},
        ],
      );
    });

    test('hidden methods', () {
      expect(
        parseMethods('''
          abstract class X {
            void _first();
            
            @internal
            void second();
            
            @visibleForTesting
            void third();
          }
        '''),
        isEmpty,
      );
    });

    test('template method', () {
      expect(
        parseMethods('''
          abstract class X {
            int flame<T>();
          }
        '''),
        [
          {
            'kind': 'method',
            'name': 'flame',
            'returns': 'int',
            'typeParameters': [
              {'name': 'T'}
            ]
          },
        ],
      );
    });

    test('method with arguments', () {
      expect(
        parseMethods('''
          abstract class X {
            int orange(bool a, int b);
          }
        '''),
        [
          {
            'kind': 'method',
            'name': 'orange',
            'returns': 'int',
            'parameters': {
              'all': [
                {'name': 'a', 'type': 'bool'},
                {'name': 'b', 'type': 'int'},
              ]
            }
          },
        ],
      );
    });

    test('method with doc-comment', () {
      expect(
        parseMethods('''
          abstract class X {
            /// Absence of color
            void white();
          }
        '''),
        [
          {
            'kind': 'method',
            'name': 'white',
            'returns': 'void',
            'description': 'Absence of color\n',
          },
        ],
      );
    });

    test('annotations on a method', () {
      expect(
        parseMethods('''
          abstract class X {
            @mustCallSuper
            @protected
            void black();
          }
        '''),
        [
          {
            'kind': 'method',
            'name': 'black',
            'returns': 'void',
            'annotations': [
              {'name': '@mustCallSuper'},
              {'name': '@protected'},
            ],
          },
        ],
      );
    });

    test('getter/setter', () {
      expect(
        parseMethods('''
          abstract class X {
            int get xyz => 3;
            set xyz(int value) {}
          }
        '''),
        [
          {
            'kind': 'getter',
            'name': 'xyz',
            'returns': 'int',
          },
          {
            'kind': 'setter',
            'name': 'xyz',
            'parameters': {
              'all': [
                {'name': 'value', 'type': 'int'}
              ],
            },
          },
        ],
      );
    });

    test('static method', () {
      expect(
        parseMethods('''
          abstract class X {
            static void magenta() {}
          }
        '''),
        [
          {
            'kind': 'method',
            'name': 'magenta',
            'returns': 'void',
            'static': true,
          },
        ],
      );
    });

    test('operator', () {
      expect(
        parseMethods('''
          abstract class X {
            bool operator==(Object other) => false;
          }
        '''),
        [
          {
            'kind': 'method',
            'name': 'operator==',
            'parameters': {
              'all': [
                {'name': 'other', 'type': 'Object'}
              ]
            },
            'returns': 'bool',
          },
        ],
      );
    });
  });
}

List parseMethods(String input) {
  final json = parseAsJson(input) as Map<String, dynamic>;
  return (json['members']! as List).where((dynamic record) {
    final kind = (record as Map<String, dynamic>)['kind'] as String;
    return {'method', 'getter', 'setter'}.contains(kind);
  }).toList();
}
