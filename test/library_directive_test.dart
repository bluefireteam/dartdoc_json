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

    // test('augment library', () {
    //   expect(
    //     parseAsJson("library augment 'main_library.dart';"),
    //     {'kind': 'library', 'augmentation': true, 'uri': 'main_library.dart'},
    //   );
    // });
  });
}
