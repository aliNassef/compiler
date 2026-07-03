import 'dart:io';

import 'expresions.dart';
import 'token.dart';

class Parser {
  List<String> _errors = [];
  final List<Token> _tokens;
  int _position = 0;
  Parser(this._tokens);

  Token get _current => _position < _tokens.length
      ? _tokens[_position]
      : Token(TokenType.EOF, '\u0000');

  Expr parsePrimary() {
    if (_current.type == TokenType.Number) {
      final token = consume();
      return NumberExpr(double.parse(token.value));
    } else if (_current.type == .OpenPran) {
      consume();
      final exp = parseExpr();
      if (_match(.ClosePran)) {
        consume();
        return exp;
      }
      exit(0);
    } else {
      _errors.add('Expected number, found ${_current.value}');
      exit(0);
    }
  }

  Expr parseExpr({int parentPrecedence = 0}) {
    late var left;
    final unaryPerencence = _current.unaryPredicate();

    if (unaryPerencence != 0 && unaryPerencence >= parentPrecedence) {
      final operator = consume();
      final right = parseExpr(parentPrecedence: unaryPerencence);
      left = UnaryExpr(operator, right);
    } else {
      left = parsePrimary();
    }

    while (true) {
      final precedence = _current.binaryPredicate();
      if (precedence == 0 || precedence <= parentPrecedence) {
        break;
      }
      final operator = consume();
      final right = parseExpr(parentPrecedence: precedence);
      left = BinaryExpr(left, operator, right);
    }
    return left;
  }

  Token consume() {
    final token = _current;
    _position++;
    return token;
  }

  void printTree(Node? node) {
    _printNode(node, "", true);
  }

  void _printNode(Node? node, String indent, bool isLast) {
    if (node == null) return;
    String marker = isLast ? "└── " : "├── ";

    stdout.write(indent);
    stdout.write(marker);

    if (node is NumberExpr) {
      print("NumberExpr(${node.value})");
    } else if (node is BinaryExpr) {
      print("BinaryExpr('${node.operator.value}')");
      String newIndent = indent + (isLast ? "    " : "│   ");

      _printNode(node.left, newIndent, false);
      _printNode(node.right, newIndent, true);
    } else if (node is UnaryExpr) {
      print("UnaryExpr('${node.operator.value}')");
      String newIndent = indent + (isLast ? "    " : "│   ");

      _printNode(node.right, newIndent, true);
    }
  }

  void reportError() {
    if (_errors.isEmpty) return;
    _errors.forEach((error) {
      print(error);
    });
  }

  bool _match(TokenType expected) {
    if (_current.type == expected) {
      return true;
    }
    _errors.add(
      'Error : expected a token ${expected} but got ${_current.type}',
    );
    return false;
  }
}
