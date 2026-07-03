import 'token.dart';

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

class UnaryExpr extends Expr {
  final Token operator;
  final Expr right;

  UnaryExpr(this.operator, this.right);

  @override
  String toString() => 'UnaryExpr(${operator.value}, right: $right)';
}

class PranExpr extends Expr {
  final Expr expr;
  PranExpr(this.expr);
}
