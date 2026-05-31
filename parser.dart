import 'dart:io';

import 'lexer.dart';

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
    } else {
      _errors.add('Expected number, found ${_current.value}');
      exit(0);
    }
  }

  Expr parseExpr({int parentPrecedence = 0}) {
    var left = parsePrimary();
    while (true) {
      final precedence = _current.getPredicate();
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
    }
  }
}

abstract class Node {}

class Expr extends Node {}

class NumberExpr extends Expr {
  final double value;
  NumberExpr(this.value);

  @override
  String toString() => 'NumberExpr($value)';
}

class BinaryExpr extends Expr {
  final Expr left;
  final Token operator;
  final Expr right;

  BinaryExpr(this.left, this.operator, this.right);

  @override
  String toString() =>
      'left: $left, BinaryExpr(${operator.value}, right: $right)';
}
