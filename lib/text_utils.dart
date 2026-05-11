final RegExp _tokenizerRegExp =
    RegExp(r"\S+|[.,;:?¿!¡'\-]", caseSensitive: false);

List<String> tokenize(String text) =>
    _tokenizerRegExp.allMatches(text).map((m) => m.group(0)!).toList();
