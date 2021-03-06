// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

import 'package:analysis_server/src/services/linter/lint_names.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'bulk_fix_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ChangeMapTest);
    defineReflectiveTests(NoFixTest);
  });
}

@reflectiveTest
class ChangeMapTest extends BulkFixProcessorTest {
  Future<void> test_changeMap() async {
    createAnalysisOptionsFile(experiments: experiments, lints: [
      LintNames.annotate_overrides,
      LintNames.unnecessary_new,
    ]);

    await resolveTestCode('''
class A { }

var a = new A();
var aa = new A();
''');

    var processor = await computeFixes();
    var changeMap = processor.changeMap;
    var errors = changeMap.libraryMap[testFile];
    expect(errors, hasLength(1));
    expect(errors[LintNames.unnecessary_new], 2);
  }
}

@reflectiveTest
class NoFixTest extends BulkFixProcessorTest {
  /// See: https://github.com/dart-lang/sdk/issues/45177
  Future<void> test_noFix() async {
    createAnalysisOptionsFile(experiments: experiments, lints: [
      'avoid_catching_errors', // NOTE: not in lintProducerMap
    ]);

    await resolveTestCode('''
void bad() {
  try {
  } on Error catch (e) {
    print(e);
  }
}
''');

    var processor = await computeFixes();
    expect(processor.fixDetails, isEmpty);
  }
}
