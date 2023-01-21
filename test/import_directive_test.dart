import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('ImportDirective', () {
    test('simple import', () {
      expect(
        parseAsJson('import "foo.dart";'),
        {'kind': 'import', 'uri': 'foo.dart'},
      );
    });

    test('multiple imports', () {
      expect(
        parseAsJson('''
          import 'dart:async';
          import 'package:meta/meta.dart';
          import 'package:analyzer/dart/ast/ast.dart' as ast;
          import 'package:test/test.dart' show group, test hide expect;
        '''),
        [
          {'kind': 'import', 'uri': 'dart:async'},
          {'kind': 'import', 'uri': 'package:meta/meta.dart'},
          {
            'kind': 'import',
            'uri': 'package:analyzer/dart/ast/ast.dart',
            'as': 'ast',
          },
          {
            'kind': 'import',
            'uri': 'package:test/test.dart',
            'show': ['group', 'test'],
            'hide': ['expect'],
          },
        ],
      );
    });
  });
}
