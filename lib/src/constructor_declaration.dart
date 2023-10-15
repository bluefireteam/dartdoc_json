import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartdoc_json/src/annotations.dart';
import 'package:dartdoc_json/src/comment.dart';
import 'package:dartdoc_json/src/formal_parameter_list.dart';
import 'package:dartdoc_json/src/utils.dart';

/// Converts a ConstructorDeclaration into a json-compatible representation.
Map<String, dynamic>? serializeConstructorDeclaration(
  ConstructorDeclaration constructor,
) {
  final annotations = serializeAnnotations(constructor.metadata);
  if ((constructor.name?.lexeme.startsWith('_') ?? false) ||
      hasPrivateAnnotation(annotations)) {
    return null;
  }
  final String className;

  if (constructor.parent is ClassDeclaration) {
    className = (constructor.parent! as ClassDeclaration).name.lexeme;
  } else if (constructor.parent is EnumDeclaration) {
    className = (constructor.parent! as EnumDeclaration).name.lexeme;
  } else {
    throw UnsupportedError(
      'Constructor parent is neither ClassDeclaration nor EnumDeclaration. '
      'It is ${constructor.parent.runtimeType}',
    );
  }

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
    'annotations': annotations,
  });
}
