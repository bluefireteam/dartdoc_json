import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/combinators.dart';
import 'package:dartdoc_json/src/utils.dart';

Map<String, dynamic> serializeImportDirective(ImportDirective import_) {
  final shows = serializeCombinators<ShowCombinator>(import_.combinators);
  final hides = serializeCombinators<HideCombinator>(import_.combinators);

  return filterMap(<String, dynamic>{
    'kind': 'import',
    'uri': import_.uri.stringValue,
    'as': import_.prefix?.token.lexeme,
    'show': shows.isEmpty ? null : shows,
    'hide': hides.isEmpty ? null : hides,
  });
}
