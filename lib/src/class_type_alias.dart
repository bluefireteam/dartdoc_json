import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/class_modifiers.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/implements_clause.dart';
import 'package:dartdoc_json/src/type_parameter_list.dart';
import 'package:dartdoc_json/src/utils.dart';
import 'package:dartdoc_json/src/with_clause.dart';

/// Serializes a ClassTypeAlias (`class C = B with M;`) into a json-compatible
/// object.
Map<String, dynamic>? serializeClassTypeAlias(ClassTypeAlias alias) {
  final annotations = serializeAnnotations(alias.metadata);
  if (alias.name.lexeme.startsWith('_') || hasPrivateAnnotation(annotations)) {
    return null;
  }
  return filterMap(<String, dynamic>{
    'kind': 'class',
    'name': alias.name.lexeme,
    'typeParameters': serializeTypeParameterList(alias.typeParameters),
    ...serializeClassModifiers(
      abstractKeyword: alias.abstractKeyword,
      baseKeyword: alias.baseKeyword,
      interfaceKeyword: alias.interfaceKeyword,
      finalKeyword: alias.finalKeyword,
      sealedKeyword: alias.sealedKeyword,
      mixinKeyword: alias.mixinKeyword,
    ),
    'extends': alias.superclass.toString(),
    'with': serializeWithClause(alias.withClause),
    'implements': serializeImplementsClause(alias.implementsClause),
    'annotations': annotations,
    'description': serializeComment(alias.documentationComment),
  });
}
