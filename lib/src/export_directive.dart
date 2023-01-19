import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/combinators.dart';
import 'package:dartdoc_json/src/utils.dart';

Map<String, dynamic> serializeExportDirective(ExportDirective export_) {
  final shows = serializeCombinators<ShowCombinator>(export_.combinators);
  final hides = serializeCombinators<HideCombinator>(export_.combinators);

  return filterMap(<String, dynamic>{
    'name': 'export',
    'uri': export_.uri.stringValue,
    'show': shows.isEmpty ? null : shows,
    'hide': hides.isEmpty ? null : hides,
  });
}
