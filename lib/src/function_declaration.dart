import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/formal_parameter_list.dart';
import 'package:dartdoc_json/src/type_parameter_list.dart';
import 'package:dartdoc_json/src/utils.dart';

/// Converts a FunctionDeclaration into a json-compatible object.
Map<String, dynamic>? serializeFunctionDeclaration(
  FunctionDeclaration function,
) {
  final annotations = serializeAnnotations(function.metadata);
  if (function.name.lexeme.startsWith('_') ||
      hasPrivateAnnotation(annotations)) {
    return null;
  }

  return filterMap(<String, dynamic>{
    'kind': 'function',
    'name': function.name.lexeme,
    'typeParameters':
        serializeTypeParameterList(function.functionExpression.typeParameters),
    'description': serializeComment(function.documentationComment),
    'parameters':
        serializeFormalParameterList(function.functionExpression.parameters),
    'returns': function.returnType?.toString(),
    'annotations': annotations,
  });
}
