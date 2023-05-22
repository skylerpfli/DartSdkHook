// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../rule_test_support.dart';

main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(VoidChecksTest);
    defineReflectiveTests(VoidChecksTestLanguage300);
  });
}

@reflectiveTest
class VoidChecksTest extends LintRuleTest {
  @override
  String get lintRule => 'void_checks';

  test_extraPositionalArgument() async {
    await assertDiagnostics(r'''
missing_parameter_for_argument() {
  void foo() {}
  foo(0);
}
''', [
      // No lint
      error(CompileTimeErrorCode.EXTRA_POSITIONAL_ARGUMENTS, 57, 1),
    ]);
  }

  /// https://github.com/dart-lang/linter/issues/4019
  test_future_dynamic() async {
    await assertNoDiagnostics(r'''
import 'dart:async';

void f(FutureOr<void>? arg) {
  Future<dynamic>? future;
  f(future);
}
''');
  }

  test_returnOfInvalidType() async {
    await assertDiagnostics(r'''
void bug2813() {
  return 1;
}
''', [
      // No lint
      error(CompileTimeErrorCode.RETURN_OF_INVALID_TYPE_FROM_FUNCTION, 26, 1),
    ]);
  }
}

@reflectiveTest
class VoidChecksTestLanguage300 extends LintRuleTest
    with LanguageVersion300Mixin {
  @override
  String get lintRule => 'void_checks';

  test_listPattern_local() async {
    await assertDiagnostics(r'''
void f() {
  void p;
  [p] = <int>[7];
  return p;
}
''', [
      lint(24, 1),
    ]);
  }

  test_listPattern_param() async {
    await assertDiagnostics(r'''
void f(void p) {
  [p] = <int>[7];
}
''', [
      lint(20, 1),
    ]);
  }

  test_recordPattern() async {
    await assertDiagnostics(r'''
void f(void p) {
  (p, ) = (7, );
}
''', [
      lint(20, 1),
    ]);
  }
}
