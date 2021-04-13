// Copyright (c) 2014, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'abstract_rename.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(RenameUnitMemberTest);
  });
}

@reflectiveTest
class RenameUnitMemberTest extends RenameRefactoringTest {
  Future<void> test_checkFinalConditions_hasTopLevel_ClassElement() async {
    await indexTestUnit('''
class Test {}
class NewName {} // existing
''');
    createRenameRefactoringAtString('Test {}');
    // check status
    refactoring.newName = 'NewName';
    var status = await refactoring.checkFinalConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.ERROR,
        expectedMessage: "Library already declares class with name 'NewName'.",
        expectedContextSearch: 'NewName {} // existing');
  }

  Future<void>
      test_checkFinalConditions_hasTopLevel_FunctionTypeAliasElement() async {
    await indexTestUnit('''
class Test {}
typedef NewName(); // existing
''');
    createRenameRefactoringAtString('Test {}');
    // check status
    refactoring.newName = 'NewName';
    var status = await refactoring.checkFinalConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.ERROR,
        expectedMessage:
            "Library already declares type alias with name 'NewName'.",
        expectedContextSearch: 'NewName(); // existing');
  }

  Future<void>
      test_checkFinalConditions_OK_qualifiedSuper_MethodElement() async {
    await indexTestUnit('''
class Test {}
class A {
  NewName() {}
}
class B extends A {
  main() {
    super.NewName(); // super-ref
  }
}
''');
    createRenameRefactoringAtString('Test {}');
    // check status
    refactoring.newName = 'NewName';
    var status = await refactoring.checkFinalConditions();
    assertRefactoringStatusOK(status);
  }

  Future<void>
      test_checkFinalConditions_publicToPrivate_usedInOtherLibrary() async {
    await indexTestUnit('''
class Test {}
''');
    await indexUnit('/home/test/lib/lib.dart', '''
library my.lib;
import 'test.dart';

main() {
  new Test();
}
''');
    createRenameRefactoringAtString('Test {}');
    // check status
    refactoring.newName = '_NewName';
    var status = await refactoring.checkFinalConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.ERROR,
        expectedMessage:
            "Renamed class will be invisible in '${convertPath("lib/lib.dart")}'.");
  }

  Future<void> test_checkFinalConditions_shadowedBy_MethodElement() async {
    await indexTestUnit('''
class Test {}
class A {
  void NewName() {}
  main() {
    new Test();
  }
}
''');
    createRenameRefactoringAtString('Test {}');
    // check status
    refactoring.newName = 'NewName';
    var status = await refactoring.checkFinalConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.ERROR,
        expectedMessage:
            "Reference to renamed class will be shadowed by method 'A.NewName'.",
        expectedContextSearch: 'NewName() {}');
  }

  Future<void> test_checkFinalConditions_shadowsInSubClass_importedLib() async {
    await indexTestUnit('''
class Test {}
''');
    await indexUnit('/home/test/lib/lib.dart', '''
library my.lib;
import 'test.dart';
class A {
  NewName() {}
}
class B extends A {
  main() {
    NewName(); // super-ref
  }",
}
''');
    createRenameRefactoringAtString('Test {}');
    // check status
    refactoring.newName = 'NewName';
    var status = await refactoring.checkFinalConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.ERROR,
        expectedMessage: "Renamed class will shadow method 'A.NewName'.");
  }

  Future<void>
      test_checkFinalConditions_shadowsInSubClass_importedLib_hideCombinator() async {
    await indexTestUnit('''
class Test {}
''');
    await indexUnit('/lib.dart', '''
library my.lib;
import 'test.dart' hide Test;
class A {
  NewName() {}
}
class B extends A {
  main() {
    NewName(); // super-ref
  }",
}
''');
    createRenameRefactoringAtString('Test {}');
    // check status
    refactoring.newName = 'NewName';
    var status = await refactoring.checkFinalConditions();
    assertRefactoringStatusOK(status);
  }

  Future<void>
      test_checkFinalConditions_shadowsInSubClass_MethodElement() async {
    await indexTestUnit('''
class Test {}
class A {
  NewName() {}
}
class B extends A {
  main() {
    NewName(); // super-ref
  }
}
''');
    createRenameRefactoringAtString('Test {}');
    // check status
    refactoring.newName = 'NewName';
    var status = await refactoring.checkFinalConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.ERROR,
        expectedMessage: "Renamed class will shadow method 'A.NewName'.",
        expectedContextSearch: 'NewName(); // super-ref');
  }

  Future<void>
      test_checkFinalConditions_shadowsInSubClass_notImportedLib() async {
    await indexUnit('/lib.dart', '''
library my.lib;
class A {
  NewName() {}
}
class B extends A {
  main() {
    NewName(); // super-ref
  }",
}
''');
    await indexTestUnit('''
class Test {}
''');
    createRenameRefactoringAtString('Test {}');
    // check status
    refactoring.newName = 'NewName';
    var status = await refactoring.checkFinalConditions();
    assertRefactoringStatusOK(status);
  }

  Future<void> test_checkFinalConditions_shadowsInSubClass_notSubClass() async {
    await indexTestUnit('''
class Test {}
class A {
  NewName() {}
}
class B {
  main(A a) {
    a.NewName();
  }
}
''');
    createRenameRefactoringAtString('Test {}');
    // check status
    refactoring.newName = 'NewName';
    var status = await refactoring.checkFinalConditions();
    assertRefactoringStatusOK(status);
  }

  Future<void> test_checkInitialConditions_inSDK() async {
    await indexTestUnit('''
main() {
  String s;
}
''');
    createRenameRefactoringAtString('String s');
    // check status
    refactoring.newName = 'NewName';
    var status = await refactoring.checkInitialConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.FATAL,
        expectedMessage:
            "The class 'String' is defined in the SDK, so cannot be renamed.");
  }

  Future<void> test_checkInitialConditions_outsideOfProject() async {
    newFile('$workspaceRootPath/aaa/lib/a.dart', content: r'''
class A {}
''');

    writeTestPackageConfig(
      config: PackageConfigFileBuilder()
        ..add(name: 'aaa', rootPath: '$workspaceRootPath/aaa'),
    );

    await indexTestUnit('''
import "package:aaa/a.dart";
main() {
  A a;
}
''');
    createRenameRefactoringAtString('A a');
    // check status
    refactoring.newName = 'NewName';
    var status = await refactoring.checkInitialConditions();
    assertRefactoringStatus(status, RefactoringProblemSeverity.FATAL,
        expectedMessage:
            "The class 'A' is defined outside of the project, so cannot be renamed.");
  }

  Future<void> test_checkNewName_ClassElement() async {
    await indexTestUnit('''
class Test {}
''');
    createRenameRefactoringAtString('Test {}');
    // null
    refactoring.newName = null;
    assertRefactoringStatus(
        refactoring.checkNewName(), RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Class name must not be null.');
    // empty
    refactoring.newName = '';
    assertRefactoringStatus(
        refactoring.checkNewName(), RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Class name must not be empty.');
    // same
    refactoring.newName = 'Test';
    assertRefactoringStatus(
        refactoring.checkNewName(), RefactoringProblemSeverity.FATAL,
        expectedMessage:
            'The new name must be different than the current name.');
    // OK
    refactoring.newName = 'NewName';
    assertRefactoringStatusOK(refactoring.checkNewName());
  }

  Future<void> test_checkNewName_FunctionElement() async {
    await indexTestUnit('''
test() {}
''');
    createRenameRefactoringAtString('test() {}');
    // null
    refactoring.newName = null;
    assertRefactoringStatus(
        refactoring.checkNewName(), RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Function name must not be null.');
    // empty
    refactoring.newName = '';
    assertRefactoringStatus(
        refactoring.checkNewName(), RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Function name must not be empty.');
    // OK
    refactoring.newName = 'newName';
    assertRefactoringStatusOK(refactoring.checkNewName());
  }

  Future<void> test_checkNewName_TopLevelVariableElement() async {
    await indexTestUnit('''
var test;
''');
    createRenameRefactoringAtString('test;');
    // null
    refactoring.newName = null;
    assertRefactoringStatus(
        refactoring.checkNewName(), RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Variable name must not be null.');
    // empty
    refactoring.newName = '';
    assertRefactoringStatus(
        refactoring.checkNewName(), RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Variable name must not be empty.');
    // OK
    refactoring.newName = 'newName';
    assertRefactoringStatusOK(refactoring.checkNewName());
  }

  Future<void> test_checkNewName_TypeAliasElement_functionType() async {
    await indexTestUnit('''
typedef Test = void Function();
''');
    createRenameRefactoringAtString('Test =');
    // null
    refactoring.newName = null;
    assertRefactoringStatus(
        refactoring.checkNewName(), RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Type alias name must not be null.');
    // OK
    refactoring.newName = 'NewName';
    assertRefactoringStatusOK(refactoring.checkNewName());
  }

  Future<void> test_checkNewName_TypeAliasElement_interfaceType() async {
    await indexTestUnit('''
typedef Test = List<int>;
''');
    createRenameRefactoringAtString('Test =');
    // null
    refactoring.newName = null;
    assertRefactoringStatus(
        refactoring.checkNewName(), RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Type alias name must not be null.');
    // OK
    refactoring.newName = 'NewName';
    assertRefactoringStatusOK(refactoring.checkNewName());
  }

  Future<void> test_checkNewName_TypeAliasElement_legacy() async {
    await indexTestUnit('''
typedef Test();
''');
    createRenameRefactoringAtString('Test();');
    // null
    refactoring.newName = null;
    assertRefactoringStatus(
        refactoring.checkNewName(), RefactoringProblemSeverity.FATAL,
        expectedMessage: 'Type alias name must not be null.');
    // OK
    refactoring.newName = 'NewName';
    assertRefactoringStatusOK(refactoring.checkNewName());
  }

  Future<void> test_createChange_ClassElement() async {
    await indexTestUnit('''
class Test implements Other {
  Test() {}
  Test.named() {}
}
class Other {
  factory Other.a() = Test;
  factory Other.b() = Test.named;
}
main() {
  Test t1 = new Test();
  Test t2 = new Test.named();
}
''');
    // configure refactoring
    createRenameRefactoringAtString('Test implements');
    expect(refactoring.refactoringName, 'Rename Class');
    expect(refactoring.elementKindName, 'class');
    expect(refactoring.oldName, 'Test');
    refactoring.newName = 'NewName';
    // validate change
    return assertSuccessfulRefactoring('''
class NewName implements Other {
  NewName() {}
  NewName.named() {}
}
class Other {
  factory Other.a() = NewName;
  factory Other.b() = NewName.named;
}
main() {
  NewName t1 = new NewName();
  NewName t2 = new NewName.named();
}
''');
  }

  Future<void> test_createChange_ClassElement_flutterWidget() async {
    writeTestPackageConfig(flutter: true);
    await indexTestUnit('''
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage();

  @override
  TestPageState createState() => new TestPageState();
}

class TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) => throw 0;
}
''');
    createRenameRefactoringAtString('TestPage extends');

    expect(refactoring.refactoringName, 'Rename Class');
    expect(refactoring.elementKindName, 'class');
    expect(refactoring.oldName, 'TestPage');
    refactoring.newName = 'NewPage';

    return assertSuccessfulRefactoring('''
import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  const NewPage();

  @override
  NewPageState createState() => new NewPageState();
}

class NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) => throw 0;
}
''');
  }

  Future<void>
      test_createChange_ClassElement_flutterWidget_privateBoth() async {
    writeTestPackageConfig(flutter: true);
    await indexTestUnit('''
import 'package:flutter/material.dart';

class _TestPage extends StatefulWidget {
  const _TestPage();

  @override
  _TestPageState createState() => new _TestPageState();
}

class _TestPageState extends State<_TestPage> {
  @override
  Widget build(BuildContext context) => throw 0;
}
''');
    createRenameRefactoringAtString('_TestPage extends');

    expect(refactoring.refactoringName, 'Rename Class');
    expect(refactoring.elementKindName, 'class');
    expect(refactoring.oldName, '_TestPage');
    refactoring.newName = '_NewPage';

    return assertSuccessfulRefactoring('''
import 'package:flutter/material.dart';

class _NewPage extends StatefulWidget {
  const _NewPage();

  @override
  _NewPageState createState() => new _NewPageState();
}

class _NewPageState extends State<_NewPage> {
  @override
  Widget build(BuildContext context) => throw 0;
}
''');
  }

  Future<void>
      test_createChange_ClassElement_flutterWidget_privateState() async {
    writeTestPackageConfig(flutter: true);
    await indexTestUnit('''
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage();

  @override
  _TestPageState createState() => new _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) => throw 0;
}
''');
    createRenameRefactoringAtString('TestPage extends');

    expect(refactoring.refactoringName, 'Rename Class');
    expect(refactoring.elementKindName, 'class');
    expect(refactoring.oldName, 'TestPage');
    refactoring.newName = 'NewPage';

    return assertSuccessfulRefactoring('''
import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  const NewPage();

  @override
  _NewPageState createState() => new _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) => throw 0;
}
''');
  }

  Future<void> test_createChange_ClassElement_invocation() async {
    verifyNoTestUnitErrors = false;
    await indexTestUnit('''
class Test {
}
main() {
  Test(); // invalid code, but still a reference
}
''');
    // configure refactoring
    createRenameRefactoringAtString('Test();');
    expect(refactoring.refactoringName, 'Rename Class');
    expect(refactoring.elementKindName, 'class');
    expect(refactoring.oldName, 'Test');
    refactoring.newName = 'NewName';
    // validate change
    return assertSuccessfulRefactoring('''
class NewName {
}
main() {
  NewName(); // invalid code, but still a reference
}
''');
  }

  Future<void> test_createChange_ClassElement_parameterTypeNested() async {
    await indexTestUnit('''
class Test {}
void f(g(Test p)) {}
''');
    // configure refactoring
    createRenameRefactoringAtString('Test {');
    expect(refactoring.refactoringName, 'Rename Class');
    expect(refactoring.oldName, 'Test');
    refactoring.newName = 'NewName';
    // validate change
    return assertSuccessfulRefactoring('''
class NewName {}
void f(g(NewName p)) {}
''');
  }

  Future<void> test_createChange_ClassElement_typeAlias() async {
    await indexTestUnit('''
class A {}
class Test = Object with A;
void f(Test t) {}
''');
    // configure refactoring
    createRenameRefactoringAtString('Test =');
    expect(refactoring.refactoringName, 'Rename Class');
    expect(refactoring.elementKindName, 'class');
    expect(refactoring.oldName, 'Test');
    refactoring.newName = 'NewName';
    // validate change
    return assertSuccessfulRefactoring('''
class A {}
class NewName = Object with A;
void f(NewName t) {}
''');
  }

  Future<void> test_createChange_FunctionElement() async {
    await indexTestUnit('''
test() {}
foo() {}
main() {
  print(test);
  print(test());
  foo();
}
''');
    // configure refactoring
    createRenameRefactoringAtString('test() {}');
    expect(refactoring.refactoringName, 'Rename Top-Level Function');
    expect(refactoring.elementKindName, 'function');
    expect(refactoring.oldName, 'test');
    refactoring.newName = 'newName';
    // validate change
    return assertSuccessfulRefactoring('''
newName() {}
foo() {}
main() {
  print(newName);
  print(newName());
  foo();
}
''');
  }

  Future<void> test_createChange_FunctionElement_imported() async {
    await indexUnit('/home/test/lib/foo.dart', r'''
test() {}
foo() {}
''');
    await indexTestUnit('''
import 'foo.dart';
main() {
  print(test);
  print(test());
  foo();
}
''');
    // configure refactoring
    createRenameRefactoringAtString('test);');
    expect(refactoring.refactoringName, 'Rename Top-Level Function');
    expect(refactoring.elementKindName, 'function');
    expect(refactoring.oldName, 'test');
    refactoring.newName = 'newName';
    // validate change
    await assertSuccessfulRefactoring('''
import 'foo.dart';
main() {
  print(newName);
  print(newName());
  foo();
}
''');
    assertFileChangeResult('/home/test/lib/foo.dart', '''
newName() {}
foo() {}
''');
  }

  Future<void> test_createChange_outsideOfProject_referenceInPart() async {
    newFile('/home/part.dart', content: r'''
part of test;

Test test2;
''');

    // To use file:// URI.
    testFile = convertPath('/home/test/bin/test.dart');

    await indexTestUnit('''
library test;

part '../../part.dart';

class Test {}

void f(Test a) {}
''');
    createRenameRefactoringAtString('Test {}');
    refactoring.newName = 'NewName';

    await assertSuccessfulRefactoring('''
library test;

part '../../part.dart';

class NewName {}

void f(NewName a) {}
''');

    expect(refactoringChange.edits, hasLength(1));
    expect(refactoringChange.edits[0].file, testFile);
  }

  Future<void>
      test_createChange_PropertyAccessorElement_getter_declaration() async {
    await _test_createChange_PropertyAccessorElement('test {}');
  }

  Future<void> test_createChange_PropertyAccessorElement_getter_usage() async {
    await _test_createChange_PropertyAccessorElement('test);');
  }

  Future<void> test_createChange_PropertyAccessorElement_mix() async {
    await _test_createChange_PropertyAccessorElement('test += 2');
  }

  Future<void>
      test_createChange_PropertyAccessorElement_setter_declaration() async {
    await _test_createChange_PropertyAccessorElement('test(x) {}');
  }

  Future<void> test_createChange_PropertyAccessorElement_setter_usage() async {
    await _test_createChange_PropertyAccessorElement('test = 1');
  }

  Future<void> test_createChange_TopLevelVariableElement_field() async {
    await _test_createChange_TopLevelVariableElement('test = 0');
  }

  Future<void> test_createChange_TopLevelVariableElement_getter() async {
    await _test_createChange_TopLevelVariableElement('test);');
  }

  Future<void> test_createChange_TopLevelVariableElement_mix() async {
    await _test_createChange_TopLevelVariableElement('test += 2');
  }

  Future<void> test_createChange_TopLevelVariableElement_setter() async {
    await _test_createChange_TopLevelVariableElement('test = 1');
  }

  Future<void> test_createChange_typeAlias_functionType() async {
    await indexTestUnit('''
typedef F = void Function();
void f(F a) {}
''');
    // configure refactoring
    createRenameRefactoringAtString('F =');
    expect(refactoring.refactoringName, 'Rename Type Alias');
    expect(refactoring.elementKindName, 'type alias');
    expect(refactoring.oldName, 'F');
    refactoring.newName = 'NewName';
    // validate change
    return assertSuccessfulRefactoring('''
typedef NewName = void Function();
void f(NewName a) {}
''');
  }

  Future<void> test_createChange_typeAlias_interfaceType() async {
    await indexTestUnit('''
typedef A<T> = Map<int, T>;
void f(A<String> a) {}
''');
    // configure refactoring
    createRenameRefactoringAtString('A<T>');
    expect(refactoring.refactoringName, 'Rename Type Alias');
    expect(refactoring.elementKindName, 'type alias');
    expect(refactoring.oldName, 'A');
    refactoring.newName = 'NewName';
    // validate change
    return assertSuccessfulRefactoring('''
typedef NewName<T> = Map<int, T>;
void f(NewName<String> a) {}
''');
  }

  Future<void> test_createChange_typeAlias_legacy() async {
    await indexTestUnit('''
typedef void F();
void f(F a) {}
''');
    // configure refactoring
    createRenameRefactoringAtString('F()');
    expect(refactoring.refactoringName, 'Rename Type Alias');
    expect(refactoring.elementKindName, 'type alias');
    expect(refactoring.oldName, 'F');
    refactoring.newName = 'G';
    // validate change
    return assertSuccessfulRefactoring('''
typedef void G();
void f(G a) {}
''');
  }

  Future<void> _test_createChange_PropertyAccessorElement(String search) async {
    await indexTestUnit('''
get test {}
set test(x) {}
main() {
  print(test);
  test = 1;
  test += 2;
}
''');
    // configure refactoring
    createRenameRefactoringAtString(search);
    expect(refactoring.refactoringName, 'Rename Top-Level Variable');
    expect(refactoring.oldName, 'test');
    refactoring.newName = 'newName';
    // validate change
    return assertSuccessfulRefactoring('''
get newName {}
set newName(x) {}
main() {
  print(newName);
  newName = 1;
  newName += 2;
}
''');
  }

  Future<void> _test_createChange_TopLevelVariableElement(String search) async {
    await indexTestUnit('''
int test = 0;
main() {
  print(test);
  test = 1;
  test += 2;
}
''');
    // configure refactoring
    createRenameRefactoringAtString(search);
    expect(refactoring.refactoringName, 'Rename Top-Level Variable');
    expect(refactoring.elementKindName, 'top level variable');
    expect(refactoring.oldName, 'test');
    refactoring.newName = 'newName';
    // validate change
    return assertSuccessfulRefactoring('''
int newName = 0;
main() {
  print(newName);
  newName = 1;
  newName += 2;
}
''');
  }
}
