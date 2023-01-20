import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/utils.dart';

/// Converts a TopLevelVariableDeclaration into a json-compatible object.
Map<String, dynamic>? serializeTopLevelVariableDeclaration(
  TopLevelVariableDeclaration variableDeclaration,
) {
  final annotations = serializeAnnotations(variableDeclaration.metadata);
  if (hasPrivateAnnotation(annotations)) {
    return null;
  }
  final variableList = variableDeclaration.variables;
  final names = <String>[];
  for (final variable in variableList.variables) {
    if (variable.name.lexeme.startsWith('_')) {
      continue;
    }
    names.add(variable.name.lexeme);
  }
  if (names.isEmpty) {
    return null;
  }
  return filterMap(<String, dynamic>{
    'kind': 'variable',
    'name': names.first,
    'extraNames': names.length > 1 ? names.sublist(1) : null,
    'type': variableList.type?.toString(),
    'description': serializeComment(variableDeclaration.documentationComment),
    'annotations': annotations,
    'final': variableList.isFinal ? true : null,
    'const': variableList.isConst ? true : null,
    'late': variableList.isLate ? true : null,
  });
}
