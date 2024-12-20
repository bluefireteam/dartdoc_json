import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/utils.dart';

Map<String, dynamic> serializeLibraryDirective(LibraryDirective library) {
  return filterMap(<String, dynamic>{
    'kind': 'library',
    'name': library.name2?.name,
  });
}
