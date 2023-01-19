import 'package:analyzer/dart/ast/ast.dart';

/// Converts EnumConstantArguments into a json-compatible representation.
List<String>? serializeEnumConstantArguments(
  EnumConstantArguments? arguments,
) {
  if (arguments == null || arguments.argumentList.arguments.isEmpty) {
    return null;
  }
  return <String>[
    for (final argument in arguments.argumentList.arguments) argument.toString()
  ];
}
