import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/formal_parameter_list.dart';
import 'package:dartdoc_json/src/utils.dart';

/// Converts a ConstructorDeclaration into a json-compatible representation.
Map<String, dynamic>? serializeConstructorDeclaration(
  ConstructorDeclaration constructor,
) {
  if (constructor.name?.lexeme.startsWith('_') ?? false) {
    return null;
  }
  final className = (constructor.parent! as ClassDeclaration).name.lexeme;
  final constructorName = constructor.name == null
      ? className
      : '$className.${constructor.name!.lexeme}';

  return filterMap(<String, dynamic>{
    'kind': 'constructor',
    'name': constructorName,
    'const': constructor.constKeyword == null ? null : true,
    'factory': constructor.factoryKeyword == null ? null : true,
    'description': serializeComment(constructor.documentationComment),
    'parameters': serializeFormalParameterList(constructor.parameters),
    'annotations': serializeAnnotations(constructor.metadata),
  });
}
