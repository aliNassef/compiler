import 'dart:io';
import 'expresions.dart';
import 'token.dart';

class Evaluator {
  List<String> _errors = [];
  double evaluate(Expr expression) {
    if (expression is NumberExpr) {
      return expression.value;
    } else if (expression is BinaryExpr) {
      final left = evaluate(expression.left);
      final right = evaluate(expression.right);
      switch (expression.operator.type) {
        case TokenType.Plus:
          return left + right;
        case TokenType.Minus:
          return left - right;
        case TokenType.Multiply:
          return left * right;
        case TokenType.Divide:
          return left / right;
        default:
          _errors.add('ERROR IN BINARY EXPRESSION');
          exit(0);
      }
    } else if (expression is UnaryExpr) {
      final right = evaluate(expression.right);
      switch (expression.operator.type) {
        case TokenType.Minus:
          return -right;
        default:
          _errors.add('ERROR IN UNARY EXPRESSION');

          exit(0);
      }
    } else {
      _errors.add('ERROR INVALID');
      exit(0);
    }
  }

  void reportError() {
    if (_errors.isEmpty) return;
    _errors.forEach((error) {
      print(error);
    });
  }
}
