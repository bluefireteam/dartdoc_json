import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/enum_constant_arguments.dart';
import 'package:dartdoc_json/src/utils.dart';

/// Converts an EnumConstantDeclaration into a json-compatible representation.
Map<String, dynamic>? serializeEnumConstantDeclaration(
  EnumConstantDeclaration constant,
) {
  if (constant.name.lexeme.startsWith('_')) {
    return null;
  }
  return filterMap(<String, dynamic>{
    'name': constant.name.lexeme,
    'description': serializeComment(constant.documentationComment),
    'annotations': serializeAnnotations(constant.metadata),
    'arguments': serializeEnumConstantArguments(constant.arguments),
  });
}
