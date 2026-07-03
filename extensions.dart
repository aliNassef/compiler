extension StringExtension on String {
  bool isDigit() {
    return this.length == 1 &&
        this.codeUnitAt(0) >= 48 &&
        this.codeUnitAt(0) <= 57;
  }

  bool isWhiteSpace() {
    if (this.length != 1) return false;
    int code = this.codeUnitAt(0);
    return code == 32;
  }

  bool isPlus() {
    return this == '+';
  }

  bool isMinus() {
    return this == '-';
  }

  bool isMultiply() {
    return this == '*';
  }

  bool isDivide() {
    return this == '/';
  }

  bool isOpenPran() {
    return this == '(';
  }

  bool isClosePran() {
    return this == ')';
  }
}
