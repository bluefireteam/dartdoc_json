import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('PartDirective', () {
    test('simple part', () {
      expect(
        parseAsJson('part "foo.dart";'),
        {'kind': 'part', 'uri': 'foo.dart'},
      );
    });

    test('multiple part', () {
      expect(
        parseAsJson('''
          part 'foo.dart';
          part 'boo.dart';
        '''),
        [
          {'kind': 'part', 'uri': 'foo.dart'},
          {'kind': 'part', 'uri': 'boo.dart'},
        ],
      );
    });
  });

  group('PartOfDirective', () {
    test('simple part', () {
      expect(
        parseAsJson('part of "foo.dart";'),
        {'kind': 'part-of', 'uri': 'foo.dart'},
      );
    });

    test('part of library', () {
      expect(
        parseAsJson('''
          part of foo;
        '''),
        {'kind': 'part-of', 'name': 'foo'},
      );
    });
  });
}
