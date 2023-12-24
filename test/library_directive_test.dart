import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('LibraryDirective', () {
    test('simple library', () {
      expect(
        parseAsJson('library foo;'),
        {'kind': 'library', 'name': 'foo'},
      );
    });
  });
}
