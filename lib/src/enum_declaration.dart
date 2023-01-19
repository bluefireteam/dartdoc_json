import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/enum_constant_declaration.dart';
import 'package:dartdoc_json/src/implements_clause.dart';
import 'package:dartdoc_json/src/member_list.dart';
import 'package:dartdoc_json/src/type_parameter_list.dart';
import 'package:dartdoc_json/src/utils.dart';
import 'package:dartdoc_json/src/with_clause.dart';

/// Converts an EnumDeclaration into a json-compatible object.
Map<String, dynamic>? serializeEnumDeclaration(EnumDeclaration enum_) {
  final annotations = serializeAnnotations(enum_.metadata);
  if (enum_.name.lexeme.startsWith('_') || hasPrivateAnnotation(annotations)) {
    return null;
  }

  return filterMap(<String, dynamic>{
    'kind': 'enum',
    'name': enum_.name.lexeme,
    'typeParameters': serializeTypeParameterList(enum_.typeParameters),
    'with': serializeWithClause(enum_.withClause),
    'implements': serializeImplementsClause(enum_.implementsClause),
    'annotations': annotations,
    'description': serializeComment(enum_.documentationComment),
    'values': [
      for (final value in enum_.constants)
        serializeEnumConstantDeclaration(value)
    ]..removeWhere((dynamic item) => item == null),
    'members': serializeMemberList(enum_.members),
  });
}
