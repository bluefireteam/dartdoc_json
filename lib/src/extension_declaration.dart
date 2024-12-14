import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/member_list.dart';
import 'package:dartdoc_json/src/type_parameter_list.dart';
import 'package:dartdoc_json/src/utils.dart';

/// Serializes an ExtensionDeclaration into a json-compatible object.
Map<String, dynamic>? serializeExtensionDeclaration(
  ExtensionDeclaration extension,
) {
  final annotations = serializeAnnotations(extension.metadata);
  if ((extension.name?.lexeme.startsWith('_') ?? false) ||
      hasPrivateAnnotation(annotations)) {
    return null;
  }
  return filterMap(<String, dynamic>{
    'kind': 'extension',
    'name': extension.name?.lexeme,
    'typeParameters': serializeTypeParameterList(extension.typeParameters),
    'on': extension.onClause.toString(),
    'annotations': annotations,
    'description': serializeComment(extension.documentationComment),
    'members': serializeMemberList(extension.members),
  });
}
