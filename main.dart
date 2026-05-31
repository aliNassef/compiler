import 'dart:io';

import 'lexer.dart';

void main() {
  while (true) {
    var line = stdin.readLineSync();
    if (line == '#quit') {
      break;
    }
    final lexer = Lexer(text: line!);
    final tokens = lexer.tokenize();
    tokens.forEach((token) {
      print('Token: ${token.type}, Value: ${token.value}');
    });

    lexer.reportError();
  }
}
