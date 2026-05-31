// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'extensions.dart';

enum TokenType {
  Number,
  WhiteSpace,
  Plus,
  Minus,
  Multiply,
  Divide,
  Invalid,
  EOF,
}

class Token {
  TokenType type;
  String value;

  Token(this.type, this.value);

  int getPredicate() {
    switch (type) {
      case TokenType.Plus || TokenType.Minus:
        return 1;
      case TokenType.Multiply || TokenType.Divide:
        return 2;
      default:
        return 0;
    }
  }
}

class Lexer {
  List<Token> _tokens = [];
  int _position = 0;
  final String text;
  String _lexeme = '';
  List<String> _errors = [];
  Lexer({required this.text});

  // make tokenization
  List<Token> tokenize() {
    while (_position < text.length) {
      _lexeme = '';
      if (_peak().isDigit()) {
        while (_peak().isDigit()) {
          _lexeme += _peak();
          _position++;
        }
        _tokens.add(Token(.Number, _lexeme));
      } else if (_peak().isWhiteSpace()) {
        while (_peak().isWhiteSpace()) {
          _lexeme += _peak();
          _position++;
        }
        // todo: handle white space in parser, for now we just ignore it.
        // _tokens.add(Token(.WhiteSpace, _lexeme));
      } else if (_peak().isPlus()) {
        _tokens.add(Token(.Plus, _peak()));
        _position++;
      } else if (_peak().isMinus()) {
        _tokens.add(Token(.Minus, _peak()));
        _position++;
      } else if (_peak().isMultiply()) {
        _tokens.add(Token(.Multiply, _peak()));
        _position++;
      } else if (_peak().isDivide()) {
        _tokens.add(Token(.Divide, _peak()));
        _position++;
      } else {
        _tokens.add(Token(.Invalid, _peak()));
        _errors.add('ERRRR INVALID TOKEN FOUND ${_peak()}');
        _position++;
      }
    }
    return _tokens;
  }

  // get current char.
  String _peak([int offest = 0]) {
    final index = _position + offest;
    return index < text.length ? text[index] : '';
  }

  void reportError() {
    if (_errors.isEmpty) return;
    _errors.forEach((error) {
      print(error);
    });
  }

  @override
  String toString() {
    return 'Lexer(tokens: $_tokens, position: $_position, text: $text, lexeme: $_lexeme)';
  }
}
