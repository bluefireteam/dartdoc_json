import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/extends_clause.dart';
import 'package:dartdoc_json/src/implements_clause.dart';
import 'package:dartdoc_json/src/member_list.dart';
import 'package:dartdoc_json/src/type_parameter_list.dart';
import 'package:dartdoc_json/src/utils.dart';
import 'package:dartdoc_json/src/with_clause.dart';

/// Converts a ClassDeclaration into a json-compatible object.
Map<String, dynamic>? serializeClassDeclaration(ClassDeclaration class_) {
  final annotations = serializeAnnotations(class_.metadata);
  if (class_.name.lexeme.startsWith('_') || hasPrivateAnnotation(annotations)) {
    return null;
  }

  return filterMap(<String, dynamic>{
    'kind': 'class',
    'name': class_.name.lexeme,
    'typeParameters': serializeTypeParameterList(class_.typeParameters),
    'abstract': class_.abstractKeyword == null ? null : true,
    'extends': serializeExtendsClause(class_.extendsClause),
    'with': serializeWithClause(class_.withClause),
    'implements': serializeImplementsClause(class_.implementsClause),
    'annotations': annotations,
    'description': serializeComment(class_.documentationComment),
    'members': serializeMemberList(class_.members),
  });
}
