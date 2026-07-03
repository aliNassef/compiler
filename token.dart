enum TokenType {
  Number,
  WhiteSpace,
  Plus,
  Minus,
  Multiply,
  Divide,
  Invalid,
  EOF,
  OpenPran,
  ClosePran
}

class Token {
  TokenType type;
  String value;

  Token(this.type, this.value);

  int binaryPredicate() {
    switch (type) {
      case TokenType.Plus || TokenType.Minus:
        return 1;
      case TokenType.Multiply || TokenType.Divide:
        return 2;
      default:
        return 0;
    }
  }

  int unaryPredicate() {
    switch (type) {
      case TokenType.Minus:
        return 3;
      default:
        return 0;
    }
  }
}
