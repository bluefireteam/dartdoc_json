import 'package:test/test.dart';
import 'utils.dart';

void main() {
  group('MixinDeclaration', () {
    test('mixin with `on` clause', () {
      expect(
        parseAsJson('mixin Moo on X, Y {}'),
        {
          'kind': 'mixin',
          'name': 'Moo',
          'on': ['X', 'Y'],
        },
      );
    });

    test('mixin with `implements` clause', () {
      expect(
        parseAsJson('''
          mixin Moo implements Sound {}
        '''),
        {
          'kind': 'mixin',
          'name': 'Moo',
          'implements': ['Sound'],
        },
      );
    });

    test('mixin with doc-comment', () {
      expect(
        parseAsJson('''
          /// This mixin moos.
          mixin Moo {
          }
        '''),
        {'kind': 'mixin', 'name': 'Moo', 'description': 'This mixin moos.\n'},
      );
    });

    test('mixin members', () {
      expect(
        parseAsJson('''
          mixin Moo {
            void bark() {}
            final bool audible = true;
          }
        '''),
        {
          'kind': 'mixin',
          'name': 'Moo',
          'members': [
            {'kind': 'method', 'name': 'bark', 'returns': 'void'},
            {'kind': 'field', 'name': 'audible', 'type': 'bool', 'final': true},
          ],
        },
      );
    });
  });
}
