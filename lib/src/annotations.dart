import 'package:analyzer/dart/ast/ast.dart';

/// Converts a list of Annotation objects into a json-compatible object.
List<Map<String, dynamic>>? serializeAnnotations(
  NodeList<Annotation> annotations,
) {
  if (annotations.isEmpty) {
    return null;
  }
  final out = <Map<String, dynamic>>[];
  for (final annotation in annotations) {
    final record = <String, dynamic>{};
    record['name'] = '@${annotation.name.name}';
    if (annotation.arguments != null) {
      record['arguments'] = [
        for (final argument in annotation.arguments!.arguments)
          argument.toString()
      ];
    }
    out.add(record);
  }
  return out;
}

/// Returns true if any of the [annotations] mark the entity as "private".
/// These annotations are:
/// - @internal
/// - @visibleForTesting
///
/// Entities with such annotations should be excluded from the documentation.
bool hasPrivateAnnotation(List<Map>? annotations) {
  if (annotations != null) {
    for (final annotation in annotations) {
      if (annotation['name'] == '@internal' ||
          annotation['name'] == '@visibleForTesting') {
        return true;
      }
    }
  }
  return false;
}
