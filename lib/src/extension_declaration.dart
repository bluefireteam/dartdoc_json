import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/member_list.dart';
import 'package:dartdoc_json/src/type_parameter_list.dart';
import 'package:dartdoc_json/src/utils.dart';

/// Serializes a MixinDeclaration into a json-compatible object.
Map<String, dynamic> serializeExtensionDeclaration(
  ExtensionDeclaration extension,
) {
  return filterMap(<String, dynamic>{
    'kind': 'extension',
    'name': extension.name?.lexeme,
    'typeParameters': serializeTypeParameterList(extension.typeParameters),
    'on': extension.extendedType.toString(),
    'annotations': serializeAnnotations(extension.metadata),
    'description': serializeComment(extension.documentationComment),
    'members': serializeMemberList(extension.members),
  });
}
