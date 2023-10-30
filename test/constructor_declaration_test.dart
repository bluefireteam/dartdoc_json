import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('ConstructorDeclaration', () {
    test('simple constructor', () {
      expect(
        parseConstructors('''
          class X {
            X();
          }
        '''),
        [
          {'kind': 'constructor', 'name': 'X'},
        ],
      );
    });

    test('private constructors', () {
      expect(
        parseConstructors('''
          class X {
            X._private();
            @internal X();
          }
        '''),
        isEmpty,
      );
    });

    test('named constructors', () {
      expect(
        parseConstructors('''
          class X {
            X._();
            X.first();
            X.second();
            X._last();
          }
        '''),
        [
          {'kind': 'constructor', 'name': 'X.first'},
          {'kind': 'constructor', 'name': 'X.second'},
        ],
      );
    });

    test('factory constructor', () {
      expect(
        parseConstructors('''
          class X {
            X._();
            factory X() { return X._(); }
            factory X.another() = X._;
          }
        '''),
        [
          {'kind': 'constructor', 'name': 'X', 'factory': true},
          {'kind': 'constructor', 'name': 'X.another', 'factory': true},
        ],
      );
    });

    test('const constructor', () {
      expect(
        parseConstructors('''
          class X {
            const X();
          }
        '''),
        [
          {'kind': 'constructor', 'name': 'X', 'const': true},
        ],
      );
    });

    test('doc-comment', () {
      expect(
        parseConstructors('''
          class X {
            /// This constructor is very important.
            X();
          }
        '''),
        [
          {
            'kind': 'constructor',
            'name': 'X',
            'description': 'This constructor is very important.\n',
          },
        ],
      );
    });

    test('annotations', () {
      expect(
        parseConstructors('''
          class X {
            @Deprecated('really')
            @external
            X();
          }
        '''),
        [
          {
            'kind': 'constructor',
            'name': 'X',
            'annotations': [
              {
                'name': '@Deprecated',
                'arguments': ["'really'"],
              },
              {'name': '@external'},
            ],
          },
        ],
      );
    });

    test('simple parameters', () {
      expect(
        parseConstructors('''
          class X {
            X(int x, double? y);
          }
        '''),
        [
          {
            'kind': 'constructor',
            'name': 'X',
            'parameters': {
              'all': [
                {'name': 'x', 'type': 'int'},
                {'name': 'y', 'type': 'double?'},
              ],
            },
          },
        ],
      );
    });

    test('positional parameters', () {
      expect(
        parseConstructors('''
          class X {
            X(a, [int x = 0, double? y]);
          }
        '''),
        [
          {
            'kind': 'constructor',
            'name': 'X',
            'parameters': {
              'all': [
                {'name': 'a'},
                {'name': 'x', 'type': 'int', 'default': '0'},
                {'name': 'y', 'type': 'double?'},
              ],
              'positional': 2,
            },
          },
        ],
      );
    });

    test('named parameters', () {
      expect(
        parseConstructors('''
          class X {
            X(int a, {required int x, double? y, bool z = false});
          }
        '''),
        [
          {
            'kind': 'constructor',
            'name': 'X',
            'parameters': {
              'all': [
                {'name': 'a', 'type': 'int'},
                {'name': 'x', 'type': 'int', 'required': true},
                {'name': 'y', 'type': 'double?'},
                {'name': 'z', 'type': 'bool', 'default': 'false'},
              ],
              'named': 3,
            },
          },
        ],
      );
    });

    test('this-parameters', () {
      expect(
        parseConstructors('''
          class X {
            X(this.x);
            final int x;
          }
        '''),
        [
          {
            'kind': 'constructor',
            'name': 'X',
            'parameters': {
              'all': [
                {'name': 'this.x'},
              ],
            },
          },
        ],
      );
    });

    test('super-parameters', () {
      expect(
        parseConstructors('''
          class X extends Y {
            X(super.x, {super.y});
          }
        '''),
        [
          {
            'kind': 'constructor',
            'name': 'X',
            'parameters': {
              'all': [
                {'name': 'super.x'},
                {'name': 'super.y'},
              ],
              'named': 1,
            },
          },
        ],
      );
    });
  });
}

List parseConstructors(String input) {
  final json = parseAsJson(input) as Map<String, dynamic>;
  return (json['members']! as List).where((dynamic record) {
    return (record as Map<String, dynamic>)['kind'] == 'constructor';
  }).toList();
}
