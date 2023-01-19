import 'package:analyzer/dart/ast/ast.dart';

/// Converts an ExtendsClause into a string.
String? serializeExtendsClause(ExtendsClause? clause) {
  return clause?.superclass.toString();
}
