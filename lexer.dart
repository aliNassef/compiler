// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'extensions.dart';

enum TokenType { Number, WhiteSpace, Plus, Minus, Multiply, Divide, Invalid }

class Token {
  TokenType type;
  String value;

  Token(this.type, this.value);
}

class Lexer {
  List<Token> tokens = [];
  int position = 0;
  final String text;
  String lexeme = '';
  List<String> errors = [];
  Lexer({required this.text});

  // make tokenization
  List<Token> tokenize() {
    while (position < text.length) {
      lexeme = '';
      if (peak().isDigit()) {
        while (peak().isDigit()) {
          lexeme += peak();
          position++;
        }
        tokens.add(Token(.Number, lexeme));
      } else if (peak().isWhiteSpace()) {
        while (peak().isWhiteSpace()) {
          lexeme += peak();
          position++;
        }
        tokens.add(Token(.WhiteSpace, lexeme));
      } else if (peak().isPlus()) {
        tokens.add(Token(.Plus, peak()));
        position++;
      } else if (peak().isMinus()) {
        tokens.add(Token(.Minus, peak()));
        position++;
      } else if (peak().isMultiply()) {
        tokens.add(Token(.Multiply, peak()));
        position++;
      } else if (peak().isDivide()) {
        tokens.add(Token(.Divide, peak()));
        position++;
      } else {
        tokens.add(Token(.Invalid, peak()));
        errors.add('ERRRR INVALID TOKEN FOUND ${peak()}');
        position++;
      }
    }
    return tokens;
  }

  // get current char.
  String peak([int offest = 0]) {
    final index = position + offest;
    return index < text.length ? text[index] : '';
  }

  @override
  String toString() {
    return 'Lexer(tokens: $tokens, position: $position, text: $text, lexeme: $lexeme)';
  }
}
