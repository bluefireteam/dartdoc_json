import 'package:analyzer/dart/ast/ast.dart' as ast;
import 'package:dartdoc_json/src/formal_parameter.dart';

/// Converts a FormalParameterList into a json-compatible object.
Map<String, dynamic>? serializeFormalParameterList(
  ast.FormalParameterList? list,
) {
  if (list?.parameters.isEmpty ?? true) {
    return null;
  }
  final nPositionalParameters =
      list!.parameters.where((p) => p.isOptionalPositional).length;
  final nNamedParameters = list.parameters.where((p) => p.isNamed).length;
  final out = <String, dynamic>{};
  out['all'] = [
    for (final param in list.parameters) serializeFormalParameter(param),
  ];
  if (nPositionalParameters != 0) {
    out['positional'] = nPositionalParameters;
  }
  if (nNamedParameters != 0) {
    out['named'] = nNamedParameters;
  }
  return out;
}
