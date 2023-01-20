import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('ExportDirective', () {
    test('simple export', () {
      expect(
        parseAsJson('export "foo.dart";'),
        {'name': 'export', 'uri': 'foo.dart'},
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
          {'name': 'export', 'uri': 'src/utils.dart'},
          {'name': 'export', 'uri': 'src/directives/export_directive.dart'},
          {
            'name': 'export',
            'uri': 'main.dart',
            'show': ['main', 'auxiliary'],
            'hide': ['Example'],
          },
        ],
      );
    });
  });
}
