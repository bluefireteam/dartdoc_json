import 'package:analyzer/dart/ast/ast.dart' as ast;
import 'package:dartdoc_json/src/type_parameter.dart';

/// Converts a TypeParameterList into a json-compatible object.
List<dynamic>? serializeTypeParameterList(ast.TypeParameterList? types) {
  if (types == null) {
    return null;
  }
  return <dynamic>[
    for (final type in types.typeParameters) serializeTypeParameter(type)
  ];
}
