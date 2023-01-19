import 'package:analyzer/dart/ast/ast.dart' as ast;
import 'package:dartdoc_json/src/constructor_declaration.dart';
import 'package:dartdoc_json/src/field_declaration.dart';
import 'package:dartdoc_json/src/method_declaration.dart';

/// Converts a MemberList into a json-compatible object.
///
/// An error will be thrown if this function encounters a member of unknown
/// type.
List<dynamic>? serializeMemberList(ast.NodeList<ast.ClassMember> _members) {
  if (_members.isEmpty) {
    return null;
  }
  final out = <dynamic>[];
  for (final member in _members) {
    Map<String, dynamic>? json;
    if (member is ast.ConstructorDeclaration) {
      json = serializeConstructorDeclaration(member);
    } else if (member is ast.MethodDeclaration) {
      json = serializeMethodDeclaration(member);
    } else if (member is ast.FieldDeclaration) {
      json = serializeFieldDeclaration(member);
    } else {
      throw AssertionError('Unknown class member: $member');
    }
    if (json != null) {
      out.add(json);
    }
  }
  return out;
}
