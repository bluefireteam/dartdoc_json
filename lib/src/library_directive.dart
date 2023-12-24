import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/utils.dart';

Map<String, dynamic> serializeLibraryDirective(LibraryDirective library) {
  return filterMap(<String, dynamic>{
    'kind': 'library',
    'name': library.name2,
  });
}

Map<String, dynamic> serializeLibraryAugmentationDirective(
  LibraryAugmentationDirective libraryAgumentation,
) {
  return filterMap(<String, dynamic>{
    'kind': 'library',
    'augmentation': true,
    'uri': libraryAgumentation.uri,
  });
}
