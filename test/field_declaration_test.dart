import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('FieldDeclaration', () {
    test('simple fields', () {
      expect(
        parseFields('''
          class X {
            X(this.a, this.b, this.t);
            
            int a;
            final bool b;
            static const List<Object> c = [];
            late final Troll t;
          }
        '''),
        [
          {'kind': 'field', 'name': 'a', 'type': 'int'},
          {'kind': 'field', 'name': 'b', 'type': 'bool', 'final': true},
          {
            'kind': 'field',
            'name': 'c',
            'type': 'List<Object>',
            'static': true,
            'const': true,
          },
          {
            'kind': 'field',
            'name': 't',
            'type': 'Troll',
            'final': true,
            'late': true,
          },
        ],
      );
    });

    test('hidden fields', () {
      expect(
        parseFields('''
          class X {
            late int _a;
            @internal late final bool b;
          }
        '''),
        isEmpty,
      );
    });

    test('multi-variable field', () {
      expect(
        parseFields('''
          class X {
            int a, b, c;
          }
        '''),
        [
          {
            'kind': 'field',
            'name': 'a',
            'extraNames': ['b', 'c'],
            'type': 'int'
          }
        ],
      );
    });

    test('comments and annotations', () {
      expect(
        parseFields('''
          class X {
            /// The first letter of the alphabet
            @important
            final int a;
          }
        '''),
        [
          {
            'kind': 'field',
            'name': 'a',
            'type': 'int',
            'final': true,
            'annotations': [
              {'name': '@important'},
            ],
            'description': 'The first letter of the alphabet\n',
          }
        ],
      );
    });
  });
}

List parseFields(String input) {
  final json = parseAsJson(input) as Map<String, dynamic>;
  return (json['members']! as List).where((dynamic record) {
    return (record as Map<String, dynamic>)['kind'] == 'field';
  }).toList();
}
