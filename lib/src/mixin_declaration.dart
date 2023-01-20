import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/implements_clause.dart';
import 'package:dartdoc_json/src/member_list.dart';
import 'package:dartdoc_json/src/on_clause.dart';
import 'package:dartdoc_json/src/type_parameter_list.dart';
import 'package:dartdoc_json/src/utils.dart';

/// Serializes a MixinDeclaration into a json-compatible object.
Map<String, dynamic> serializeMixinDeclaration(MixinDeclaration mixin) {
  return filterMap(<String, dynamic>{
    'kind': 'mixin',
    'name': mixin.name.lexeme,
    'typeParameters': serializeTypeParameterList(mixin.typeParameters),
    'implements': serializeImplementsClause(mixin.implementsClause),
    'on': serializeOnClause(mixin.onClause),
    'annotations': serializeAnnotations(mixin.metadata),
    'description': serializeComment(mixin.documentationComment),
    'members': serializeMemberList(mixin.members),
  });
}
