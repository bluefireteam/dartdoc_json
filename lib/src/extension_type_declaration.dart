// The ExtensionTypeDeclaration and RepresentationDeclaration AST nodes are
// still marked experimental in the analyzer, even though extension types are
// a stable language feature since Dart 3.3.
// ignore_for_file: experimental_member_use

import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/implements_clause.dart';
import 'package:dartdoc_json/src/member_list.dart';
import 'package:dartdoc_json/src/type_parameter_list.dart';
import 'package:dartdoc_json/src/utils.dart';

/// Serializes an ExtensionTypeDeclaration into a json-compatible object.
Map<String, dynamic>? serializeExtensionTypeDeclaration(
  ExtensionTypeDeclaration extensionType,
) {
  final annotations = serializeAnnotations(extensionType.metadata);
  if (extensionType.name.lexeme.startsWith('_') ||
      hasPrivateAnnotation(annotations)) {
    return null;
  }
  return filterMap(<String, dynamic>{
    'kind': 'extension-type',
    'name': extensionType.name.lexeme,
    'typeParameters': serializeTypeParameterList(extensionType.typeParameters),
    'const': extensionType.constKeyword == null ? null : true,
    'representation': serializeRepresentation(extensionType.representation),
    'implements': serializeImplementsClause(extensionType.implementsClause),
    'annotations': annotations,
    'description': serializeComment(extensionType.documentationComment),
    'members': serializeMemberList(extensionType.members),
  });
}

/// Serializes the representation declaration (the `(int value)` part) of an
/// extension type into a json-compatible object.
Map<String, dynamic> serializeRepresentation(
  RepresentationDeclaration representation,
) {
  return filterMap(<String, dynamic>{
    'name': representation.fieldName.lexeme,
    'type': representation.fieldType.toString(),
    'constructorName': representation.constructorName?.name.lexeme,
  });
}
