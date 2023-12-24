import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/utils.dart';

Map<String, dynamic> serializePartDirective(PartDirective part) {
  return filterMap(<String, dynamic>{
    'kind': 'part',
    'uri': part.uri.stringValue,
  });
}

Map<String, dynamic> serializePartOfDirective(PartOfDirective partOf) {
  return filterMap(<String, dynamic>{
    'kind': 'part-of',
    'uri': partOf.uri?.stringValue,
    'name': partOf.libraryName?.name,
  });
}
