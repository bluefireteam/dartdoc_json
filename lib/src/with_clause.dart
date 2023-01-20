import 'package:analyzer/dart/ast/ast.dart';

/// Converts a WithClause into a json-compatible object.
List<String>? serializeWithClause(WithClause? clause) {
  if (clause == null) {
    return null;
  }
  return [for (final type in clause.mixinTypes) type.toString()];
}
