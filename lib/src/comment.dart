import 'package:analyzer/dart/ast/ast.dart';

/// Converts a documentation Comment into a simple string.
///
/// The line structure will be preserved, but the comment markers "///" will
/// be stripped.
String? serializeComment(Comment? comment) {
  if (comment == null) {
    return null;
  }
  final lines = <String>[];
  for (final fullLine in comment.tokens) {
    final line = fullLine.lexeme.trim();
    int prefixLength;
    if (line.startsWith('/// ')) {
      prefixLength = 4;
    } else if (line.startsWith('///') || line.startsWith('// ')) {
      prefixLength = 3;
    } else if (line.startsWith('//')) {
      prefixLength = 2;
    } else {
      throw ArgumentError('Invalid comment line: "$fullLine"');
    }
    lines.add('${line.substring(prefixLength)}\n');
  }
  return lines.join();
}
