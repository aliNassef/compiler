import 'dart:io';

import 'evaluator.dart';
import 'lexer.dart';
import 'parser.dart';

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
    final parser = Parser(tokens);
    final expr = parser.parseExpr();
    print('Expr: $expr');
    print('\n Tree:');
    parser.printTree(expr);
    parser.reportError();
    print('Parse Complete');
    Evaluator evaluatte = Evaluator();
    final resultOfEvaluate = evaluatte.evaluate(expr);
    print('Result Of Evaluation is ${resultOfEvaluate}');
    evaluatte.reportError();
  }
}
