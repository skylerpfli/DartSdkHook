// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

import 'package:analysis_server/src/services/correction/fix.dart';
import 'package:analysis_server/src/services/linter/lint_names.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'fix_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(RemoveUnnecessaryStringInterpolationTest);
  });
}

@reflectiveTest
class RemoveUnnecessaryStringInterpolationTest extends FixProcessorLintTest {
  @override
  FixKind get kind => DartFixKind.REMOVE_UNNECESSARY_STRING_INTERPOLATION;

  @override
  String get lintCode => LintNames.unnecessary_string_interpolations;

  Future<void> test_doubleQuote_noBrackets() async {
    await resolveTestCode(r'''
void f() {
  const test = 'testing';
  "$test";
}
''');
    await assertHasFix(r'''
void f() {
  const test = 'testing';
  test;
}
''');
  }

  Future<void> test_doubleQuote_withBrackets() async {
    await resolveTestCode(r'''
void f() {
  const test = 'testing';
  "${test}";
}
''');
    await assertHasFix(r'''
void f() {
  const test = 'testing';
  test;
}
''');
  }

  Future<void> test_maintainPrecedence_hasParentheses() async {
    await resolveTestCode(r'''
void f(String s) {
  print('${(s * 2)}'.length);
}
''');
    await assertHasFix(r'''
void f(String s) {
  print((s * 2).length);
}
''');
  }

  Future<void> test_maintainPrecedence_noParentheses() async {
    await resolveTestCode(r'''
void f(String s) {
  print('${s * 2}'.length);
}
''');
    await assertHasFix(r'''
void f(String s) {
  print((s * 2).length);
}
''');
  }

  Future<void> test_maintainPrecedence_unaryPrefix_addParentheses() async {
    await resolveTestCode(r'''
extension Minusable on String {
  String operator -() => '-$this';
}

void f(String s) {
  print('${-  s}'.length);
}
''');
    await assertHasFix(r'''
extension Minusable on String {
  String operator -() => '-$this';
}

void f(String s) {
  print((-  s).length);
}
''');
  }

  Future<void> test_maintainPrecedence_unaryPrefix_doNotAddParentheses() async {
    await resolveTestCode(r'''
extension Minusable on String {
  String operator -() => '-$this';
}

void f(String s) {
  print('${-s}');
}
''');
    await assertHasFix(r'''
extension Minusable on String {
  String operator -() => '-$this';
}

void f(String s) {
  print(-s);
}
''');
  }

  Future<void> test_singleQuote_noBrackets() async {
    await resolveTestCode(r'''
void f() {
  const test = 'testing';
  '$test';
}
''');
    await assertHasFix(r'''
void f() {
  const test = 'testing';
  test;
}
''');
  }

  Future<void> test_singleQuote_withBrackets() async {
    await resolveTestCode(r'''
void f() {
  const test = 'testing';
  '${test}';
}
''');
    await assertHasFix(r'''
void f() {
  const test = 'testing';
  test;
}
''');
  }

  Future<void> test_tripleDoubleQuote_noBrackets() async {
    await resolveTestCode(r'''
void f() {
  const test = 'testing';
  """$test""";
}
''');
    await assertHasFix(r'''
void f() {
  const test = 'testing';
  test;
}
''');
  }

  Future<void> test_tripleDoubleQuote_withBrackets() async {
    await resolveTestCode(r'''
void f() {
  const test = 'testing';
  """${test}""";
}
''');
    await assertHasFix(r'''
void f() {
  const test = 'testing';
  test;
}
''');
  }

  Future<void> test_tripleSingleQuote_noBrackets() async {
    await resolveTestCode(r"""
void f() {
  const test = 'testing';
  '''$test''';
}
""");
    await assertHasFix(r'''
void f() {
  const test = 'testing';
  test;
}
''');
  }

  Future<void> test_tripleSingleQuote_withBrackets() async {
    await resolveTestCode(r"""
void f() {
  const test = 'testing';
  '''${test}''';
}
""");
    await assertHasFix(r'''
void f() {
  const test = 'testing';
  test;
}
''');
  }
}
