// Copyright (c) 2014, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

import 'dart:convert';

import 'package:analysis_server/src/services/linter/lint_names.dart';
import 'package:analysis_server/src/services/refactoring/extract_local.dart';
import 'package:analysis_server/src/services/refactoring/refactoring.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'abstract_refactoring.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ExtractLocalTest);
  });
}

@reflectiveTest
class ExtractLocalTest extends RefactoringTest {
  @override
  ExtractLocalRefactoringImpl refactoring;

  Future<void> test_checkFinalConditions_sameVariable_after() async {
    await indexTestUnit('''
main() {
  int a = 1 + 2;
  var res;
}
''');
    _createRefactoringForString('1 + 2');
    // conflicting name
    var status = await refactoring.checkAllConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.ERROR,
        expectedMessage: "The name 'res' is already used in the scope.");
  }

  Future<void> test_checkFinalConditions_sameVariable_before() async {
    await indexTestUnit('''
main() {
  var res;
  int a = 1 + 2;
}
''');
    _createRefactoringForString('1 + 2');
    // conflicting name
    var status = await refactoring.checkAllConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.ERROR,
        expectedMessage: "The name 'res' is already used in the scope.");
  }

  Future<void> test_checkInitialCondition_false_outOfRange_length() async {
    await indexTestUnit('''
main() {
  print(1 + 2);
}
''');
    _createRefactoring(0, 1 << 20);
    var status = await refactoring.checkAllConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.FATAL);
  }

  Future<void> test_checkInitialCondition_outOfRange_offset() async {
    await indexTestUnit('''
main() {
  print(1 + 2);
}
''');
    _createRefactoring(-10, 20);
    var status = await refactoring.checkAllConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.FATAL);
  }

  Future<void> test_checkInitialConditions_assignmentLeftHandSize() async {
    await indexTestUnit('''
main() {
  var v = 0;
  v = 1;
}
''');
    _createRefactoringWithSuffix('v', ' = 1;');
    // check conditions
    var status = await refactoring.checkAllConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Cannot extract the left-hand side of an assignment.');
  }

  Future<void>
      test_checkInitialConditions_namePartOfDeclaration_function() async {
    await indexTestUnit('''
void main() {
  void foo() {}
}
''');
    _createRefactoringWithSuffix('foo', '()');
    // check conditions
    var status = await refactoring.checkAllConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Cannot extract the name part of a declaration.');
  }

  Future<void>
      test_checkInitialConditions_namePartOfDeclaration_variable() async {
    await indexTestUnit('''
main() {
  int vvv = 0;
}
''');
    _createRefactoringWithSuffix('vvv', ' = 0;');
    // check conditions
    var status = await refactoring.checkAllConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Cannot extract the name part of a declaration.');
  }

  Future<void> test_checkInitialConditions_noExpression() async {
    await indexTestUnit('''
main() {
  // abc
}
''');
    _createRefactoringForString('abc');
    // check conditions
    await _assertInitialConditions_fatal_selection();
  }

  Future<void> test_checkInitialConditions_notPartOfFunction() async {
    await indexTestUnit('''
int a = 1 + 2;
''');
    _createRefactoringForString('1 + 2');
    // check conditions
    var status = await refactoring.checkAllConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.FATAL,
        expectedMessage: 'An expression inside a function must be selected '
            'to activate this refactoring.');
  }

  Future<void>
      test_checkInitialConditions_stringSelection_leadingQuote() async {
    await indexTestUnit('''
main() {
  var vvv = 'abc';
}
''');
    _createRefactoringForString("'a");
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 'abc';
  var vvv = res;
}
''');
  }

  Future<void>
      test_checkInitialConditions_stringSelection_trailingQuote() async {
    await indexTestUnit('''
main() {
  var vvv = 'abc';
}
''');
    _createRefactoringForString("c'");
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 'abc';
  var vvv = res;
}
''');
  }

  Future<void> test_checkInitialConditions_voidExpression() async {
    await indexTestUnit('''
main() {
  print(42);
}
''');
    _createRefactoringForString('print');
    // check conditions
    var status = await refactoring.checkInitialConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Cannot extract the void expression.');
  }

  Future<void> test_checkName() async {
    await indexTestUnit('''
main() {
  int a = 1 + 2;
}
''');
    _createRefactoringForString('1 + 2');
    expect(refactoring.refactoringName, 'Extract Local Variable');
    // null
    refactoring.name = null;
    assertRefactoringStatus(
        refactoring.checkName(), RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Variable name must not be null.');
    // empty
    refactoring.name = '';
    assertRefactoringStatus(
        refactoring.checkName(), RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Variable name must not be empty.');
    // OK
    refactoring.name = 'res';
    assertRefactoringStatusOK(refactoring.checkName());
  }

  Future<void> test_checkName_conflict_withInvokedFunction() async {
    await indexTestUnit('''
main() {
  int a = 1 + 2;
  res();
}

void res() {}
''');
    _createRefactoringForString('1 + 2');
    await refactoring.checkInitialConditions();
    refactoring.name = 'res';
    assertRefactoringStatus(
        refactoring.checkName(), RefactoringProblemSeverity.ERROR,
        expectedMessage: "The name 'res' is already used in the scope.");
  }

  Future<void> test_checkName_conflict_withOtherLocal() async {
    await indexTestUnit('''
main() {
  var res;
  int a = 1 + 2;
}
''');
    _createRefactoringForString('1 + 2');
    await refactoring.checkInitialConditions();
    refactoring.name = 'res';
    assertRefactoringStatus(
        refactoring.checkName(), RefactoringProblemSeverity.ERROR,
        expectedMessage: "The name 'res' is already used in the scope.");
  }

  Future<void> test_checkName_conflict_withTypeName() async {
    await indexTestUnit('''
main() {
  int a = 1 + 2;
  Res? b = null;
}

class Res {}
''');
    _createRefactoringForString('1 + 2');
    await refactoring.checkInitialConditions();
    refactoring.name = 'Res';
    assertRefactoringStatus(
        refactoring.checkName(), RefactoringProblemSeverity.ERROR,
        expectedMessage: "The name 'Res' is already used in the scope.");
  }

  Future<void> test_completeStatementExpression() async {
    await indexTestUnit('''
main(p) {
  p.toString();
}
''');
    _createRefactoringForString('p.toString()');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main(p) {
  var res = p.toString();
}
''');
  }

  Future<void> test_const_argument_inConstInstanceCreation() async {
    await indexTestUnit('''
class A {
  const A(int a, int b);
}
main() {
  const A(1, 2);
}
''');
    _createRefactoringForString('1');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
class A {
  const A(int a, int b);
}
main() {
  const res = 1;
  const A(res, 2);
}
''');
  }

  Future<void> test_const_inList() async {
    await indexTestUnit('''
main() {
  const [1, 2];
}
''');
    _createRefactoringForString('1');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  const res = 1;
  const [res, 2];
}
''');
  }

  Future<void> test_const_inList_inBinaryExpression() async {
    await indexTestUnit('''
main() {
  const [1 + 2, 3];
}
''');
    _createRefactoringForString('1');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  const res = 1;
  const [res + 2, 3];
}
''');
  }

  Future<void> test_const_inList_inConditionalExpression() async {
    await indexTestUnit('''
main() {
  const [true ? 1 : 2, 3];
}
''');
    _createRefactoringForString('1');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  const res = 1;
  const [true ? res : 2, 3];
}
''');
  }

  Future<void> test_const_inList_inParenthesis() async {
    await indexTestUnit('''
main() {
  const [(1), 2];
}
''');
    _createRefactoringForString('1');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  const res = 1;
  const [(res), 2];
}
''');
  }

  Future<void> test_const_inList_inPrefixExpression() async {
    await indexTestUnit('''
main() {
  const [!true, 2];
}
''');
    _createRefactoringForString('true');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  const res = true;
  const [!res, 2];
}
''');
  }

  Future<void> test_const_inMap_key() async {
    await indexTestUnit('''
main() {
  const {1: 2};
}
''');
    _createRefactoringForString('1');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  const res = 1;
  const {res: 2};
}
''');
  }

  Future<void> test_const_inMap_value() async {
    await indexTestUnit('''
main() {
  const {1: 2};
}
''');
    _createRefactoringForString('2');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  const res = 2;
  const {1: res};
}
''');
  }

  Future<void> test_coveringExpressions() async {
    await indexTestUnit('''
main() {
  int aaa = 1;
  int bbb = 2;
  var c = aaa + bbb * 2 + 3;
}
''');
    _createRefactoring(testCode.indexOf('bb * 2'), 0);
    // check conditions
    await refactoring.checkInitialConditions();
    var subExpressions = _getCoveringExpressions();
    expect(subExpressions,
        ['bbb', 'bbb * 2', 'aaa + bbb * 2', 'aaa + bbb * 2 + 3']);
  }

  Future<void> test_coveringExpressions_inArgumentList() async {
    await indexTestUnit('''
main() {
  foo(111 + 222);
}
int foo(int x) => x;
''');
    _createRefactoring(testCode.indexOf('11 +'), 0);
    // check conditions
    await refactoring.checkInitialConditions();
    var subExpressions = _getCoveringExpressions();
    expect(subExpressions, ['111', '111 + 222', 'foo(111 + 222)']);
  }

  Future<void> test_coveringExpressions_inInvocationOfVoidFunction() async {
    await indexTestUnit('''
main() {
  foo(111 + 222);
}
void foo(int x) {}
''');
    _createRefactoring(testCode.indexOf('11 +'), 0);
    // check conditions
    await refactoring.checkInitialConditions();
    var subExpressions = _getCoveringExpressions();
    expect(subExpressions, ['111', '111 + 222']);
  }

  Future<void> test_coveringExpressions_namedExpression_value() async {
    await indexTestUnit('''
main() {
  foo(ppp: 42);
}
int foo({int ppp: 0}) => ppp + 1;
''');
    _createRefactoring(testCode.indexOf('42'), 0);
    // check conditions
    await refactoring.checkInitialConditions();
    var subExpressions = _getCoveringExpressions();
    expect(subExpressions, ['42', 'foo(ppp: 42)']);
  }

  Future<void> test_coveringExpressions_skip_assignment() async {
    await indexTestUnit('''
main() {
  int v;
  foo(v = 111 + 222);
}
int foo(x) => 42;
''');
    _createRefactoring(testCode.indexOf('11 +'), 0);
    // check conditions
    await refactoring.checkInitialConditions();
    var subExpressions = _getCoveringExpressions();
    expect(subExpressions, ['111', '111 + 222', 'foo(v = 111 + 222)']);
  }

  Future<void> test_coveringExpressions_skip_constructorName() async {
    await indexTestUnit('''
class AAA {
  AAA.name() {}
}
main() {
  var v = new AAA.name();
}
''');
    _createRefactoring(testCode.indexOf('AA.name();'), 5);
    // check conditions
    await refactoring.checkInitialConditions();
    var subExpressions = _getCoveringExpressions();
    expect(subExpressions, ['new AAA.name()']);
  }

  Future<void> test_coveringExpressions_skip_constructorName_name() async {
    await indexTestUnit('''
class A {
  A.name() {}
}
main() {
  var v = new A.name();
}
''');
    _createRefactoring(testCode.indexOf('ame();'), 0);
    // check conditions
    await refactoring.checkInitialConditions();
    var subExpressions = _getCoveringExpressions();
    expect(subExpressions, ['new A.name()']);
  }

  Future<void> test_coveringExpressions_skip_constructorName_type() async {
    await indexTestUnit('''
class A {}
main() {
  var v = new A();
}
''');
    _createRefactoring(testCode.indexOf('A();'), 0);
    // check conditions
    await refactoring.checkInitialConditions();
    var subExpressions = _getCoveringExpressions();
    expect(subExpressions, ['new A()']);
  }

  Future<void>
      test_coveringExpressions_skip_constructorName_typeArgument() async {
    await indexTestUnit('''
class A<T> {}
main() {
  var v = new A<String>();
}
''');
    _createRefactoring(testCode.indexOf('ring>'), 0);
    // check conditions
    await refactoring.checkInitialConditions();
    var subExpressions = _getCoveringExpressions();
    expect(subExpressions, ['new A<String>()']);
  }

  Future<void> test_coveringExpressions_skip_namedExpression() async {
    await indexTestUnit('''
main() {
  foo(ppp: 42);
}
int foo({int ppp: 0}) => ppp + 1;
''');
    _createRefactoring(testCode.indexOf('pp: 42'), 0);
    // check conditions
    await refactoring.checkInitialConditions();
    var subExpressions = _getCoveringExpressions();
    expect(subExpressions, ['foo(ppp: 42)']);
  }

  Future<void> test_fragmentExpression() async {
    await indexTestUnit('''
main() {
  int a = 1 + 2 + 3 + 4;
}
''');
    _createRefactoringForString('2 + 3');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 1 + 2 + 3;
  int a = res + 4;
}
''');
  }

  Future<void> test_fragmentExpression_leadingNotWhitespace() async {
    await indexTestUnit('''
main() {
  int a = 1 + 2 + 3 + 4;
}
''');
    _createRefactoringForString('+ 2');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 1 + 2;
  int a = res + 3 + 4;
}
''');
  }

  Future<void> test_fragmentExpression_leadingPartialSelection() async {
    await indexTestUnit('''
main() {
  int a = 111 + 2 + 3 + 4;
}
''');
    _createRefactoringForString('11 + 2');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 111 + 2;
  int a = res + 3 + 4;
}
''');
  }

  Future<void> test_fragmentExpression_leadingWhitespace() async {
    await indexTestUnit('''
main() {
  int a = 1 + 2 + 3 + 4;
}
''');
    _createRefactoringForString(' 2 + 3');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 1 + 2 + 3;
  int a = res + 4;
}
''');
  }

  Future<void> test_fragmentExpression_notAssociativeOperator() async {
    await indexTestUnit('''
main() {
  int a = 1 - 2 - 3 - 4;
}
''');
    _createRefactoringForString('2 - 3');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 1 - 2 - 3;
  int a = res - 4;
}
''');
  }

  Future<void> test_fragmentExpression_trailingNotWhitespace() async {
    await indexTestUnit('''
main() {
  int a = 1 + 2 + 3 + 4;
}
''');
    _createRefactoringForString('1 + 2 +');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 1 + 2 + 3;
  int a = res + 4;
}
''');
  }

  Future<void> test_fragmentExpression_trailingPartialSelection() async {
    await indexTestUnit('''
main() {
  int a = 1 + 2 + 333 + 4;
}
''');
    _createRefactoringForString('2 + 33');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 1 + 2 + 333;
  int a = res + 4;
}
''');
  }

  Future<void> test_fragmentExpression_trailingWhitespace() async {
    await indexTestUnit('''
main() {
  int a = 1 + 2 + 3 + 4;
}
''');
    _createRefactoringForString('2 + 3 ');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 1 + 2 + 3;
  int a = res + 4;
}
''');
  }

  Future<void> test_guessNames_fragmentExpression() async {
    await indexTestUnit('''
main() {
  var a = 111 + 222 + 333 + 444;
}
''');
    _createRefactoringForString('222 + 333');
    // check guesses
    await refactoring.checkInitialConditions();
    expect(refactoring.names, unorderedEquals(['i']));
  }

  Future<void> test_guessNames_singleExpression() async {
    await indexTestUnit('''
class TreeItem {}
TreeItem? getSelectedItem() => null;
process(my) {}
main() {
  process(getSelectedItem()); // marker
}
''');
    _createRefactoringWithSuffix('getSelectedItem()', '); // marker');
    // check guesses
    await refactoring.checkInitialConditions();
    expect(refactoring.names,
        unorderedEquals(['selectedItem', 'item', 'my', 'treeItem']));
  }

  Future<void> test_guessNames_stringPart() async {
    await indexTestUnit('''
main() {
  var s = 'Hello Bob... welcome to Dart!';
}
''');
    _createRefactoringForString('Hello Bob');
    // check guesses
    await refactoring.checkInitialConditions();
    expect(refactoring.names, unorderedEquals(['helloBob', 'bob']));
  }

  Future<void> test_isAvailable_false_notPartOfFunction() async {
    await indexTestUnit('''
var v = 1 + 2;
''');
    _createRefactoringForString('1 + 2');
    expect(refactoring.isAvailable(), isFalse);
  }

  Future<void> test_isAvailable_true() async {
    await indexTestUnit('''
main() {
  print(1 + 2);
}
''');
    _createRefactoringForString('1 + 2');
    expect(refactoring.isAvailable(), isTrue);
  }

  Future<void> test_lint_prefer_final_locals() async {
    createAnalysisOptionsFile(lints: [LintNames.prefer_final_locals]);
    await indexTestUnit('''
main() {
  print(1 + 2);
}
''');
    _createRefactoringForString('1 + 2');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  final res = 1 + 2;
  print(res);
}
''');
  }

  Future<void> test_occurrences_differentName_samePrefix() async {
    await indexTestUnit('''
void f(A a) {
  if (a.foo != 1) {
  } else if (a.foo2 != 2) {
  }
}

class A {
  int? foo;
  int? foo2;
}
''');
    _createRefactoringWithSuffix('a.foo', ' != 1');
    // apply refactoring
    await _assertSuccessfulRefactoring('''
void f(A a) {
  var res = a.foo;
  if (res != 1) {
  } else if (a.foo2 != 2) {
  }
}

class A {
  int? foo;
  int? foo2;
}
''');
  }

  Future<void> test_occurrences_differentVariable() async {
    await indexTestUnit('''
main() {
  {
    int v = 1;
    print(v + 1); // marker
    print(v + 1);
  }
  {
    int v = 2;
    print(v + 1);
  }
}
''');
    _createRefactoringWithSuffix('v + 1', '); // marker');
    // apply refactoring
    await _assertSuccessfulRefactoring('''
main() {
  {
    int v = 1;
    var res = v + 1;
    print(res); // marker
    print(res);
  }
  {
    int v = 2;
    print(v + 1);
  }
}
''');
    _assertSingleLinkedEditGroup(
        length: 3, offsets: [36, 59, 85], names: ['object', 'i']);
  }

  Future<void> test_occurrences_disableOccurrences() async {
    await indexTestUnit('''
int foo() => 42;
main() {
  int a = 1 + foo();
  int b = 2 + foo(); // marker
}
''');
    _createRefactoringWithSuffix('foo()', '; // marker');
    refactoring.extractAll = false;
    // apply refactoring
    return _assertSuccessfulRefactoring('''
int foo() => 42;
main() {
  int a = 1 + foo();
  var res = foo();
  int b = 2 + res; // marker
}
''');
  }

  Future<void> test_occurrences_ignore_assignmentLeftHandSize() async {
    await indexTestUnit('''
main() {
  int v = 1;
  v = 2;
  print(() {v = 2;});
  print(1 + (() {v = 2; return 3;})());
  print(v); // marker
}
''');
    _createRefactoringWithSuffix('v', '); // marker');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  int v = 1;
  v = 2;
  print(() {v = 2;});
  print(1 + (() {v = 2; return 3;})());
  var res = v;
  print(res); // marker
}
''');
  }

  Future<void> test_occurrences_ignore_nameOfVariableDeclaration() async {
    await indexTestUnit('''
main() {
  int v = 1;
  print(v); // marker
}
''');
    _createRefactoringWithSuffix('v', '); // marker');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  int v = 1;
  var res = v;
  print(res); // marker
}
''');
  }

  Future<void> test_occurrences_singleExpression() async {
    await indexTestUnit('''
int foo() => 42;
main() {
  int a = 1 + foo();
  int b = 2 +  foo(); // marker
}
''');
    _createRefactoringWithSuffix('foo()', '; // marker');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
int foo() => 42;
main() {
  var res = foo();
  int a = 1 + res;
  int b = 2 +  res; // marker
}
''');
  }

  Future<void> test_occurrences_useDominator() async {
    await indexTestUnit('''
main() {
  if (true) {
    print(42);
  } else {
    print(42);
  }
}
''');
    _createRefactoringForString('42');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 42;
  if (true) {
    print(res);
  } else {
    print(res);
  }
}
''');
  }

  Future<void> test_occurrences_whenComment() async {
    await indexTestUnit('''
int foo() => 42;
main() {
  /*int a = 1 + foo();*/
  int b = 2 + foo(); // marker
}
''');
    _createRefactoringWithSuffix('foo()', '; // marker');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
int foo() => 42;
main() {
  /*int a = 1 + foo();*/
  var res = foo();
  int b = 2 + res; // marker
}
''');
  }

  Future<void> test_occurrences_withSpace() async {
    await indexTestUnit('''
int foo(String s) => 42;
main() {
  int a = 1 + foo('has space');
  int b = 2 + foo('has space'); // marker
}
''');
    _createRefactoringWithSuffix("foo('has space')", '; // marker');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
int foo(String s) => 42;
main() {
  var res = foo('has space');
  int a = 1 + res;
  int b = 2 + res; // marker
}
''');
  }

  Future<void> test_offsets_lengths() async {
    await indexTestUnit('''
int foo() => 42;
main() {
  int a = 1 + foo(); // marker
  int b = 2 + foo( );
}
''');
    _createRefactoringWithSuffix('foo()', '; // marker');
    // check offsets
    await refactoring.checkInitialConditions();
    expect(refactoring.offsets,
        unorderedEquals([findOffset('foo();'), findOffset('foo( );')]));
    expect(refactoring.lengths, unorderedEquals([5, 6]));
  }

  Future<void> test_singleExpression() async {
    await indexTestUnit('''
main() {
  int a = 1 + 2;
}
''');
    _createRefactoringForString('1 + 2');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 1 + 2;
  int a = res;
}
''');
  }

  Future<void> test_singleExpression_getter() async {
    await indexTestUnit('''
class A {
  int get foo => 42;
}
main() {
  A a = new A();
  int b = 1 + a.foo; // marker
}
''');
    _createRefactoringWithSuffix('a.foo', '; // marker');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
class A {
  int get foo => 42;
}
main() {
  A a = new A();
  var res = a.foo;
  int b = 1 + res; // marker
}
''');
  }

  @FailingTest(issue: 'https://github.com/dart-lang/sdk/issues/33992')
  Future<void> test_singleExpression_hasParseError_expectedSemicolon() async {
    verifyNoTestUnitErrors = false;
    await indexTestUnit('''
main(p) {
  foo
  p.bar.baz;
}
''');
    _createRefactoringForString('p.bar');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main(p) {
  foo
  var res = p.bar;
  res.baz;
}
''');
  }

  Future<void> test_singleExpression_inExpressionBody_ofClosure() async {
    await indexTestUnit('''
main() {
  print((x) => x.y * x.y + 1);
}
''');
    _createRefactoringForString('x.y');
    // apply refactoring
    await _assertSuccessfulRefactoring('''
main() {
  print((x) {
    var res = x.y;
    return res * res + 1;
  });
}
''');
    _assertSingleLinkedEditGroup(
        length: 3, offsets: [31, 53, 59], names: ['y']);
  }

  Future<void> test_singleExpression_inExpressionBody_ofFunction() async {
    await indexTestUnit('''
foo(Point p) => p.x * p.x + p.y * p.y;
class Point {int x = 0; int y = 0;}
''');
    _createRefactoringForString('p.x');
    // apply refactoring
    await _assertSuccessfulRefactoring('''
foo(Point p) {
  var res = p.x;
  return res * res + p.y * p.y;
}
class Point {int x = 0; int y = 0;}
''');
    _assertSingleLinkedEditGroup(
        length: 3, offsets: [21, 41, 47], names: ['x', 'i']);
  }

  Future<void> test_singleExpression_inExpressionBody_ofMethod() async {
    await indexTestUnit('''
class A {
  foo(Point p) => p.x * p.x + p.y * p.y;
}
class Point {int x = 0; int y = 0;}
''');
    _createRefactoringForString('p.x');
    // apply refactoring
    await _assertSuccessfulRefactoring('''
class A {
  foo(Point p) {
    var res = p.x;
    return res * res + p.y * p.y;
  }
}
class Point {int x = 0; int y = 0;}
''');
    _assertSingleLinkedEditGroup(
        length: 3, offsets: [35, 57, 63], names: ['x', 'i']);
  }

  Future<void> test_singleExpression_inIfElseIf() async {
    await indexTestUnit('''
void f(int p) {
  if (p == 1) {
    print(1);
  } else if (p == 2) {
    print(2);
  }
}
''');
    _createRefactoringForString('2');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
void f(int p) {
  var res = 2;
  if (p == 1) {
    print(1);
  } else if (p == res) {
    print(res);
  }
}
''');
  }

  Future<void> test_singleExpression_inMethod() async {
    await indexTestUnit('''
class A {
  main() {
    print(1 + 2);
  }
}
''');
    _createRefactoringForString('1 + 2');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
class A {
  main() {
    var res = 1 + 2;
    print(res);
  }
}
''');
  }

  Future<void> test_singleExpression_leadingNotWhitespace() async {
    await indexTestUnit('''
main() {
  int a = 12 + 345;
}
''');
    _createRefactoringForString('+ 345');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 12 + 345;
  int a = res;
}
''');
  }

  Future<void> test_singleExpression_leadingWhitespace() async {
    await indexTestUnit('''
main() {
  int a = 1 /*abc*/ + 2 + 345;
}
''');
    _createRefactoringForString('1 /*abc*/');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 1 /*abc*/ + 2;
  int a = res + 345;
}
''');
  }

  Future<void> test_singleExpression_methodName_reference() async {
    await indexTestUnit('''
main() {
  var v = foo().length;
}
String foo() => '';
''');
    _createRefactoringWithSuffix('foo', '().');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = foo();
  var v = res.length;
}
String foo() => '';
''');
  }

  Future<void> test_singleExpression_nameOfProperty_prefixedIdentifier() async {
    await indexTestUnit('''
main(p) {
  var v = p.value; // marker
}
''');
    _createRefactoringWithSuffix('value', '; // marker');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main(p) {
  var res = p.value;
  var v = res; // marker
}
''');
  }

  Future<void> test_singleExpression_nameOfProperty_propertyAccess() async {
    await indexTestUnit('''
main() {
  var v = foo().length; // marker
}
String foo() => '';
''');
    _createRefactoringWithSuffix('length', '; // marker');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = foo().length;
  var v = res; // marker
}
String foo() => '';
''');
  }

  /// Here we use knowledge how exactly `1 + 2 + 3 + 4` is parsed. We know that
  /// `1 + 2` will be a separate and complete binary expression, so it can be
  /// handled as a single expression.
  Future<void> test_singleExpression_partOfBinaryExpression() async {
    await indexTestUnit('''
main() {
  int a = 1 + 2 + 3 + 4;
}
''');
    _createRefactoringForString('1 + 2');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 1 + 2;
  int a = res + 3 + 4;
}
''');
  }

  Future<void> test_singleExpression_string() async {
    await indexTestUnit('''
void main() {
  print("1234");
}
''');
    _createRefactoringAtString('34"');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
void main() {
  var res = "1234";
  print(res);
}
''');
  }

  Future<void> test_singleExpression_trailingNotWhitespace() async {
    await indexTestUnit('''
main() {
  int a = 12 + 345;
}
''');
    _createRefactoringForString('12 +');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 12 + 345;
  int a = res;
}
''');
  }

  Future<void> test_singleExpression_trailingWhitespace() async {
    await indexTestUnit('''
main() {
  int a = 1 + 2 ;
}
''');
    _createRefactoringForString('1 + 2 ');
    // apply refactoring
    return _assertSuccessfulRefactoring('''
main() {
  var res = 1 + 2;
  int a = res ;
}
''');
  }

  Future<void> test_stringLiteral_part() async {
    await indexTestUnit('''
main() {
  print('abcdefgh');
}
''');
    _createRefactoringForString('cde');
    // apply refactoring
    await _assertSuccessfulRefactoring(r'''
main() {
  var res = 'cde';
  print('ab${res}fgh');
}
''');
    _assertSingleLinkedEditGroup(length: 3, offsets: [15, 41], names: ['cde']);
  }

  Future<void> test_stringLiteral_whole() async {
    await indexTestUnit('''
main() {
  print('abc');
}
''');
    _createRefactoringForString("'abc'");
    // apply refactoring
    await _assertSuccessfulRefactoring('''
main() {
  var res = 'abc';
  print(res);
}
''');
    _assertSingleLinkedEditGroup(
        length: 3, offsets: [15, 36], names: ['object', 's']);
  }

  Future<void> test_stringLiteralPart() async {
    await indexTestUnit(r'''
main() {
  int x = 1;
  int y = 2;
  print('$x+$y=${x+y}');
}
''');
    _createRefactoringForString(r'$x+$y');
    // apply refactoring
    await _assertSuccessfulRefactoring(r'''
main() {
  int x = 1;
  int y = 2;
  var res = '$x+$y';
  print('${res}=${x+y}');
}
''');
    _assertSingleLinkedEditGroup(length: 3, offsets: [41, 67], names: ['xy']);
  }

  Future _assertInitialConditions_fatal_selection() async {
    var status = await refactoring.checkInitialConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.FATAL,
        expectedMessage:
            'Expression must be selected to activate this refactoring.');
  }

  void _assertSingleLinkedEditGroup(
      {int length, List<int> offsets, List<String> names}) {
    var positions =
        offsets.map((offset) => {'file': testFile, 'offset': offset});
    var suggestions = names.map((name) => {'value': name, 'kind': 'VARIABLE'});
    var expected = <String, dynamic>{
      'length': length,
      'positions': positions.toList(),
      'suggestions': suggestions.toList()
    };
    _assertSingleLinkedEditGroupJson(json.encode(expected));
  }

  void _assertSingleLinkedEditGroupJson(String expectedJsonString) {
    var editGroups = refactoringChange.linkedEditGroups;
    expect(editGroups, hasLength(1));
    expect(editGroups.first.toJson(), json.decode(expectedJsonString));
  }

  /// Checks that all conditions are OK and the result of applying the
  /// [SourceChange] to [testUnit] is [expectedCode].
  Future _assertSuccessfulRefactoring(String expectedCode) async {
    await assertRefactoringConditionsOK();
    var refactoringChange = await refactoring.createChange();
    this.refactoringChange = refactoringChange;
    assertTestChangeResult(expectedCode);
  }

  void _createRefactoring(int offset, int length) {
    refactoring = ExtractLocalRefactoring(testAnalysisResult, offset, length);
    refactoring.name = 'res';
  }

  /// Creates a new refactoring in [refactoring] at the offset of the given
  /// [search] pattern, and with the length `0`.
  void _createRefactoringAtString(String search) {
    var offset = findOffset(search);
    var length = 0;
    _createRefactoring(offset, length);
  }

  /// Creates a new refactoring in [refactoring] for the selection range of the
  /// given [search] pattern.
  void _createRefactoringForString(String search) {
    var offset = findOffset(search);
    var length = search.length;
    _createRefactoring(offset, length);
  }

  void _createRefactoringWithSuffix(String selectionSearch, String suffix) {
    var offset = findOffset(selectionSearch + suffix);
    var length = selectionSearch.length;
    _createRefactoring(offset, length);
  }

  List<String> _getCoveringExpressions() {
    var subExpressions = <String>[];
    for (var i = 0; i < refactoring.coveringExpressionOffsets.length; i++) {
      var offset = refactoring.coveringExpressionOffsets[i];
      var length = refactoring.coveringExpressionLengths[i];
      subExpressions.add(testCode.substring(offset, offset + length));
    }
    return subExpressions;
  }
}
