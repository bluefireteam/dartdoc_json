import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/formal_parameter_list.dart';
import 'package:dartdoc_json/src/type_parameter_list.dart';
import 'package:dartdoc_json/src/utils.dart';

/// Converts a MethodDeclaration into a json-compatible object.
Map<String, dynamic>? serializeMethodDeclaration(MethodDeclaration method) {
  final annotations = serializeAnnotations(method.metadata);
  if (method.name.lexeme.startsWith('_') || hasPrivateAnnotation(annotations)) {
    return null;
  }

  return filterMap(<String, dynamic>{
    'kind': method.isGetter
        ? 'getter'
        : method.isSetter
            ? 'setter'
            : 'method',
    'name': (method.isOperator ? 'operator' : '') + method.name.lexeme,
    'typeParameters': serializeTypeParameterList(method.typeParameters),
    'description': serializeComment(method.documentationComment),
    'parameters': serializeFormalParameterList(method.parameters),
    'returns': method.returnType?.toString(),
    'annotations': annotations,
    'static': method.isStatic ? true : null,
  });
}
