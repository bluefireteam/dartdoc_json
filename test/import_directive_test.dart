import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('ImportDirective', () {
    test('simple import', () {
      expect(
        parseAsJson('import "foo.dart";'),
        {'name': 'import', 'uri': 'foo.dart'},
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
          {'name': 'import', 'uri': 'dart:async'},
          {'name': 'import', 'uri': 'package:meta/meta.dart'},
          {
            'name': 'import',
            'uri': 'package:analyzer/dart/ast/ast.dart',
            'as': 'ast',
          },
          {
            'name': 'import',
            'uri': 'package:test/test.dart',
            'show': ['group', 'test'],
            'hide': ['expect'],
          },
        ],
      );
    });
  });
}
