import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('ExportDirective', () {
    test('simple export', () {
      expect(
        parseAsJson('export "foo.dart";'),
        {'kind': 'export', 'uri': 'foo.dart'},
      );
    });

    test('multiple exports', () {
      expect(
        parseAsJson('''
          export 'src/utils.dart';
          export 'src/directives/export_directive.dart';
          export 'main.dart'
            show main, auxiliary
            hide Example;
        '''),
        [
          {'kind': 'export', 'uri': 'src/utils.dart'},
          {'kind': 'export', 'uri': 'src/directives/export_directive.dart'},
          {
            'kind': 'export',
            'uri': 'main.dart',
            'show': ['main', 'auxiliary'],
            'hide': ['Example'],
          },
        ],
      );
    });
  });
}
