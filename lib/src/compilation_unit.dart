import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/class_declaration.dart';
import 'package:dartdoc_json/src/enum_declaration.dart';
import 'package:dartdoc_json/src/export_directive.dart';
import 'package:dartdoc_json/src/extension_declaration.dart';
import 'package:dartdoc_json/src/function_declaration.dart';
import 'package:dartdoc_json/src/generic_type_alias.dart';
import 'package:dartdoc_json/src/import_directive.dart';
import 'package:dartdoc_json/src/library_directive.dart';
import 'package:dartdoc_json/src/mixin_declaration.dart';
import 'package:dartdoc_json/src/part_directive.dart';
import 'package:dartdoc_json/src/top_level_variable_declaration.dart';

Map<String, dynamic> serializeCompilationUnit(CompilationUnit unit) {
  final declarations = <Map<String, dynamic>>[];
  for (final declaration in unit.declarations) {
    Map<String, dynamic>? serialized;
    if (declaration is ClassDeclaration) {
      serialized = serializeClassDeclaration(declaration);
    } else if (declaration is MixinDeclaration) {
      serialized = serializeMixinDeclaration(declaration);
    } else if (declaration is ExtensionDeclaration) {
      serialized = serializeExtensionDeclaration(declaration);
    } else if (declaration is GenericTypeAlias) {
      serialized = serializeGenericTypeAlias(declaration);
    } else if (declaration is EnumDeclaration) {
      serialized = serializeEnumDeclaration(declaration);
    } else if (declaration is FunctionDeclaration) {
      serialized = serializeFunctionDeclaration(declaration);
    } else if (declaration is TopLevelVariableDeclaration) {
      serialized = serializeTopLevelVariableDeclaration(declaration);
    } else {
      throw AssertionError(
        'Unknown declaration type: ${declaration.runtimeType}',
      );
    }
    if (serialized != null) {
      declarations.add(serialized);
    }
  }
  final directives = <Map<String, dynamic>>[];
  for (final directive in unit.directives) {
    late Map<String, dynamic> serialized;
    if (directive is ImportDirective) {
      serialized = serializeImportDirective(directive);
    } else if (directive is AugmentationImportDirective) {
      serialized = serializeAugmentationImportDirective(directive);
    } else if (directive is ExportDirective) {
      serialized = serializeExportDirective(directive);
    } else if (directive is LibraryDirective) {
      serialized = serializeLibraryDirective(directive);
    } else if (directive is LibraryAugmentationDirective) {
      serialized = serializeLibraryAugmentationDirective(directive);
    } else if (directive is PartDirective) {
      serialized = serializePartDirective(directive);
    } else if (directive is PartOfDirective) {
      serialized = serializePartOfDirective(directive);
    } else {
      throw AssertionError('Unknown directive type: ${directive.runtimeType}');
    }
    directives.add(serialized);
  }

  final result = <String, dynamic>{};
  if (declarations.isNotEmpty) {
    result['declarations'] = declarations;
  }
  if (directives.isNotEmpty) {
    result['directives'] = directives;
  }
  return result;
}
