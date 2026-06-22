import 'package:analyzer/dart/ast/token.dart';

/// Serializes the class modifier keywords into a json-compatible object.
///
/// Each modifier that is present is represented as a `true` value, and absent
/// modifiers are represented as `null` so that `filterMap` can remove them.
Map<String, dynamic> serializeClassModifiers({
  Token? abstractKeyword,
  Token? baseKeyword,
  Token? interfaceKeyword,
  Token? finalKeyword,
  Token? sealedKeyword,
  Token? mixinKeyword,
}) {
  return <String, dynamic>{
    'abstract': abstractKeyword == null ? null : true,
    'base': baseKeyword == null ? null : true,
    'interface': interfaceKeyword == null ? null : true,
    'final': finalKeyword == null ? null : true,
    'sealed': sealedKeyword == null ? null : true,
    'mixinClass': mixinKeyword == null ? null : true,
  };
}
