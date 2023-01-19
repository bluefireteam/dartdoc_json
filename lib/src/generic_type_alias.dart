import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/type_parameter_list.dart';
import 'package:dartdoc_json/src/utils.dart';

/// Converts a GenericTypeAlias (typedef) into a json-compatible object.
Map<String, dynamic>? serializeGenericTypeAlias(GenericTypeAlias alias) {
  final annotations = serializeAnnotations(alias.metadata);
  if (alias.name.lexeme.startsWith('_') || hasPrivateAnnotation(annotations)) {
    return null;
  }
  return filterMap(<String, dynamic>{
    'kind': 'typedef',
    'name': alias.name.lexeme,
    'typeParameters': serializeTypeParameterList(alias.typeParameters),
    'annotations': annotations,
    'description': serializeComment(alias.documentationComment),
  });
}
