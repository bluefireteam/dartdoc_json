import 'package:analyzer/dart/ast/ast.dart' as ast;

/// Converts a TypeParameter into a json-compatible object.
Map<String, String> serializeTypeParameter(ast.TypeParameter _type) {
  final out = {
    'name': _type.name.lexeme,
  };
  if (_type.bound != null) {
    out['extends'] = _type.bound!.toString();
  }
  return out;
}
