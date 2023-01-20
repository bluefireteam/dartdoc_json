import 'package:analyzer/dart/ast/ast.dart';

/// Serializes an ImplementsClause into a json-compatible object.
List<String>? serializeImplementsClause(ImplementsClause? clause) {
  if (clause == null) {
    return null;
  }
  return [for (final type in clause.interfaces) type.toString()];
}
