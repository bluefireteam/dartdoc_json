import 'package:analyzer/dart/ast/ast.dart' as ast;

/// Converts a TypeParameter into a json-compatible object.
Map<String, String> serializeTypeParameter(ast.TypeParameter type) {
  final out = {
    'name': type.name.lexeme,
  };
  if (type.bound != null) {
    out['extends'] = type.bound!.toString();
  }
  return out;
}
