import 'package:analyzer/dart/ast/ast.dart';

List<String> serializeCombinators<C extends Combinator>(
  NodeList<Combinator> combinators,
) {
  return [
    for (final combinator in combinators)
      if (combinator is C)
        for (final name in _names(combinator)) name.token.lexeme,
  ];
}

List<SimpleIdentifier> _names(Combinator combinator) {
  if (combinator is ShowCombinator) {
    return combinator.shownNames;
  } else if (combinator is HideCombinator) {
    return combinator.hiddenNames;
  } else {
    return [];
  }
}
