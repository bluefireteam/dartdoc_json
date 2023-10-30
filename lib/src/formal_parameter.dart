import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/utils.dart';

/// Converts a FormalParameter into a json-compatible object.
Map<String, dynamic> serializeFormalParameter(FormalParameter parameter) {
  var p = parameter;
  String? defaultValue;
  if (p is DefaultFormalParameter) {
    defaultValue = p.defaultValue?.toString();
    p = p.parameter;
  }
  String? type;
  var name = p.name?.lexeme;
  if (p is FieldFormalParameter) {
    name = 'this.$name';
  } else if (p is SuperFormalParameter) {
    name = 'super.$name';
  } else if (p is SimpleFormalParameter) {
    type = p.type?.toString();
  }
  return filterMap(<String, dynamic>{
    'name': name,
    'type': type,
    'covariant': p.covariantKeyword == null ? null : true,
    'default': defaultValue,
    'required': p.isRequiredNamed ? true : null,
  });
}
