import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/utils.dart';

/// Converts a FieldDeclaration into a json-compatible object.
Map<String, dynamic>? serializeFieldDeclaration(
  FieldDeclaration fieldDeclaration,
) {
  final annotations = serializeAnnotations(fieldDeclaration.metadata);
  if (hasPrivateAnnotation(annotations)) {
    return null;
  }
  final field = fieldDeclaration.fields;
  final names = <String>[];
  for (final variable in field.variables) {
    if (variable.name.lexeme.startsWith('_')) {
      continue;
    }
    names.add(variable.name.lexeme);
  }
  if (names.isEmpty) {
    return null;
  }
  return filterMap(<String, dynamic>{
    'kind': 'field',
    'name': names.first,
    'extraNames': names.length > 1 ? names.sublist(1) : null,
    'type': field.type?.toString(),
    'description': serializeComment(fieldDeclaration.documentationComment),
    'annotations': annotations,
    'static': fieldDeclaration.isStatic ? true : null,
    'final': field.isFinal ? true : null,
    'const': field.isConst ? true : null,
    'late': field.isLate ? true : null,
  });
}
