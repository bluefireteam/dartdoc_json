import 'package:analyzer/dart/ast/ast.dart' as ast;

/// Converts an OnClause into a json-compatible object.
List<String>? serializeOnClause(ast.OnClause? clause) {
  if (clause == null) {
    return null;
  }
  return [for (final type in clause.superclassConstraints) type.toString()];
}
