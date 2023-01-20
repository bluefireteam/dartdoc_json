import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:dartdoc_json/src/compilation_unit.dart';

dynamic parseAsJson(String content) {
  final parsed = parseString(
    content: content,
    featureSet: FeatureSet.latestLanguageVersion(),
  );
  final unit = serializeCompilationUnit(parsed.unit);
  final declarations = unit['declarations'] as List?;
  final directives = unit['directives'] as List?;
  if (declarations == null && directives == null) {
    return unit;
  } else if (declarations == null) {
    return directives!.length == 1 ? directives.first : directives;
  } else if (directives == null) {
    return declarations.length == 1 ? declarations.first : declarations;
  } else {
    return unit;
  }
}
