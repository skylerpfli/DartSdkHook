// Copyright (c) 2014, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analysis_server/src/analysis_server.dart';
import 'package:analysis_server/src/domain_analysis.dart';
import 'package:analysis_server/src/domain_completion.dart';
import 'package:analysis_server/src/plugin/plugin_manager.dart';
import 'package:analysis_server/src/protocol_server.dart';
import 'package:analysis_server/src/provisional/completion/dart/completion_dart.dart';
import 'package:analysis_server/src/server/crash_reporting_attachments.dart';
import 'package:analysis_server/src/utilities/mocks.dart';
import 'package:analyzer/instrumentation/service.dart';
import 'package:analyzer/src/generated/sdk.dart';
import 'package:analyzer/src/test_utilities/mock_sdk.dart';
import 'package:analyzer/src/test_utilities/resource_provider_mixin.dart';
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'domain_completion_util.dart';
import 'mocks.dart';
import 'src/plugin/plugin_manager_test.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(CompletionDomainHandlerGetSuggestions2Test);
    defineReflectiveTests(CompletionDomainHandlerGetSuggestionsTest);
  });
}

@reflectiveTest
class CompletionDomainHandlerGetSuggestions2Test with ResourceProviderMixin {
  late final MockServerChannel serverChannel;
  late final AnalysisServer server;

  AnalysisDomainHandler get analysisDomain {
    return server.handlers.whereType<AnalysisDomainHandler>().single;
  }

  CompletionDomainHandler get completionDomain {
    return server.handlers.whereType<CompletionDomainHandler>().single;
  }

  String get testFilePath => '$testPackageLibPath/test.dart';

  String get testPackageLibPath => '$testPackageRootPath/lib';

  String get testPackageRootPath => '$workspaceRootPath/test';

  String get workspaceRootPath => '/home';

  Future<void> setRoots({
    required List<String> included,
    required List<String> excluded,
  }) async {
    var includedConverted = included.map(convertPath).toList();
    var excludedConverted = excluded.map(convertPath).toList();
    await _handleSuccessfulRequest(
      AnalysisSetAnalysisRootsParams(
        includedConverted,
        excludedConverted,
        packageRoots: {},
      ).toRequest('0'),
    );
  }

  void setUp() {
    serverChannel = MockServerChannel();

    var sdkRoot = newFolder('/sdk');
    createMockSdk(
      resourceProvider: resourceProvider,
      root: sdkRoot,
    );

    server = AnalysisServer(
      serverChannel,
      resourceProvider,
      AnalysisServerOptions(),
      DartSdkManager(sdkRoot.path),
      CrashReportingAttachmentsBuilder.empty,
      InstrumentationService.NULL_SERVICE,
    );
  }

  Future<void> test_numResults_class_methods() async {
    await _configureWithWorkspaceRoot();

    var responseValidator = await _getTestCodeSuggestions('''
class A {
  void foo01() {}
  void foo02() {}
  void foo03() {}
}

void f(A a) {
  a.foo0^
}
''', maxResults: 2);

    responseValidator.assertReplacementBack(4);

    var suggestionsValidator = responseValidator.suggestions;
    suggestionsValidator.assertCompletions(['foo01', 'foo02']);
  }

  Future<void> test_numResults_topLevelVariables() async {
    await _configureWithWorkspaceRoot();

    var responseValidator = await _getTestCodeSuggestions('''
var foo01 = 0;
var foo02 = 0;
var foo03 = 0;

void f() {
  foo0^
}
''', maxResults: 2);

    responseValidator.assertReplacementBack(4);

    var suggestionsValidator = responseValidator.suggestions;
    suggestionsValidator.assertCompletions(['foo01', 'foo02']);
    suggestionsValidator
        .withCompletion('foo01')
        .assertSingle()
        .assertTopLevelVariable();
    suggestionsValidator
        .withCompletion('foo02')
        .assertSingle()
        .assertTopLevelVariable();
  }

  Future<void> test_numResults_topLevelVariables_imported_withPrefix() async {
    await _configureWithWorkspaceRoot();

    newFile('$testPackageLibPath/a.dart', content: '''
var foo01 = 0;
var foo02 = 0;
var foo03 = 0;
''');

    var responseValidator = await _getTestCodeSuggestions('''
import 'a.dart' as prefix;

void f() {
  prefix.^
}
''', maxResults: 2);

    responseValidator.assertEmptyReplacement();

    var suggestionsValidator = responseValidator.suggestions;
    suggestionsValidator.assertCompletions(['foo01', 'foo02']);
  }

  Future<void> test_prefixed_class_constructors() async {
    await _configureWithWorkspaceRoot();

    var responseValidator = await _getTestCodeSuggestions('''
class A {
  A.foo01();
  A.foo02();
}

void f() {
  A.foo0^
}
''');

    responseValidator.assertReplacementBack(4);

    var suggestions = responseValidator.suggestions;
    suggestions.assertCompletions(['foo01', 'foo02']);
    suggestions.withCompletion('foo01').assertSingle().assertConstructor();
    suggestions.withCompletion('foo02').assertSingle().assertConstructor();
  }

  Future<void> test_prefixed_class_getters() async {
    await _configureWithWorkspaceRoot();

    var responseValidator = await _getTestCodeSuggestions('''
class A {
  int get foo01 => 0;
  int get foo02 => 0;
}

void f(A a) {
  a.foo0^
}
''');

    responseValidator.assertReplacementBack(4);

    var suggestions = responseValidator.suggestions;
    suggestions.assertCompletions(['foo01', 'foo02']);
    suggestions.withCompletion('foo01').assertSingle().assertGetter();
    suggestions.withCompletion('foo02').assertSingle().assertGetter();
  }

  Future<void> test_prefixed_class_methods_instance() async {
    await _configureWithWorkspaceRoot();

    var responseValidator = await _getTestCodeSuggestions('''
class A {
  void foo01() {}
  void foo02() {}
}

void f(A a) {
  a.foo0^
}
''');

    responseValidator.assertReplacementBack(4);

    var suggestions = responseValidator.suggestions;
    suggestions.assertCompletions(['foo01', 'foo02']);
    suggestions.withCompletion('foo01').assertSingle().assertMethod();
    suggestions.withCompletion('foo02').assertSingle().assertMethod();
  }

  Future<void> test_prefixed_class_methods_static() async {
    await _configureWithWorkspaceRoot();

    var responseValidator = await _getTestCodeSuggestions('''
class A {
  static void foo01() {}
  static void foo02() {}
}

void f() {
  A.foo0^
}
''');

    responseValidator.assertReplacementBack(4);

    var suggestions = responseValidator.suggestions;
    suggestions.assertCompletions(['foo01', 'foo02']);
    suggestions.withCompletion('foo01').assertSingle().assertMethod();
    suggestions.withCompletion('foo02').assertSingle().assertMethod();
  }

  Future<void> test_prefixed_extensionGetters() async {
    await _configureWithWorkspaceRoot();

    var responseValidator = await _getTestCodeSuggestions(r'''
extension E1 on int {
  int get foo01 => 0;
  int get foo02 => 0;
  int get bar => 0;
}

extension E2 on double {
  int get foo03 => 0;
}

void f() {
  0.foo0^
}
''');

    responseValidator.assertReplacementBack(4);

    var suggestionsValidator = responseValidator.suggestions;
    suggestionsValidator.assertCompletions(['foo01', 'foo02']);

    suggestionsValidator.withCompletion('foo01').assertSingle().assertGetter();
    suggestionsValidator.withCompletion('foo02').assertSingle().assertGetter();
  }

  /// TODO(scheglov) Also not imported, with type checks.
  Future<void> test_prefixed_extensionGetters_imported() async {
    await _configureWithWorkspaceRoot();

    newFile('$testPackageLibPath/a.dart', content: '''
extension E1 on int {
  int get foo01 => 0;
  int get foo02 => 0;
  int get bar => 0;
}

extension E2 on double {
  int get foo03 => 0;
}
''');

    var responseValidator = await _getTestCodeSuggestions(r'''
import 'a.dart';

void f() {
  0.foo0^
}
''');

    responseValidator.assertReplacementBack(4);

    var suggestionsValidator = responseValidator.suggestions;
    suggestionsValidator.assertCompletions(['foo01', 'foo02']);

    suggestionsValidator.withCompletion('foo01').assertSingle().assertGetter();
    suggestionsValidator.withCompletion('foo02').assertSingle().assertGetter();
  }

  Future<void> test_unprefixed_filters() async {
    await _configureWithWorkspaceRoot();

    var responseValidator = await _getTestCodeSuggestions(r'''
var foo01 = 0;
var foo02 = 0;
var bar01 = 0;
var bar02 = 0;

void f() {
  foo0^
}
''');

    responseValidator.assertReplacementBack(4);

    var suggestionsValidator = responseValidator.suggestions;
    suggestionsValidator.assertCompletions(['foo01', 'foo02']);

    suggestionsValidator
        .withCompletion('foo01')
        .assertSingle()
        .assertTopLevelVariable();
    suggestionsValidator
        .withCompletion('foo02')
        .assertSingle()
        .assertTopLevelVariable();
    suggestionsValidator.withCompletion('bar01').assertEmpty();
    suggestionsValidator.withCompletion('bar02').assertEmpty();
  }

  Future<void> test_unprefixed_imported_class() async {
    await _configureWithWorkspaceRoot();

    newFile('$testPackageLibPath/a.dart', content: '''
class A01 {}
''');

    newFile('$testPackageLibPath/b.dart', content: '''
class A02 {}
''');

    var responseValidator = await _getTestCodeSuggestions('''
import 'a.dart';
import 'b.dart';

void f() {
  A0^
}
''');

    responseValidator.assertReplacementBack(2);

    var classes = responseValidator.suggestions.withElementClass();
    classes.assertCompletions(['A01', 'A02']);
    classes.withCompletion('A01').assertSingle().assertClass();
    classes.withCompletion('A02').assertSingle().assertClass();
  }

  Future<void> test_unprefixed_imported_topLevelVariable() async {
    await _configureWithWorkspaceRoot();

    newFile('$testPackageLibPath/a.dart', content: '''
var foo01 = 0;
''');

    newFile('$testPackageLibPath/b.dart', content: '''
var foo02 = 0;
''');

    var responseValidator = await _getTestCodeSuggestions('''
import 'a.dart';
import 'b.dart';

void f() {
  foo0^
}
''');

    responseValidator.assertReplacementBack(4);

    var suggestionsValidator = responseValidator.suggestions;
    suggestionsValidator.assertCompletions(['foo01', 'foo02']);
    suggestionsValidator
        .withCompletion('foo01')
        .assertSingle()
        .assertTopLevelVariable();
    suggestionsValidator
        .withCompletion('foo02')
        .assertSingle()
        .assertTopLevelVariable();
  }

  Future<void> test_unprefixed_sorts_byScore() async {
    await _configureWithWorkspaceRoot();

    var responseValidator = await _getTestCodeSuggestions(r'''
var fooAB = 0;
var fooBB = 0;

void f() {
  fooB^
}
''');

    responseValidator.assertReplacementBack(4);

    var suggestionsValidator = responseValidator.suggestions;
    // `fooBB` has better score than `fooAB` - prefix match
    suggestionsValidator.assertCompletions(['fooBB', 'fooAB']);
  }

  Future<void> test_unprefixed_sorts_byType() async {
    await _configureWithWorkspaceRoot();

    var responseValidator = await _getTestCodeSuggestions(r'''
var foo01 = 0.0;
var foo02 = 0;

void f() {
  int v = foo0^
}
''');

    responseValidator.assertReplacementBack(4);

    var suggestionsValidator = responseValidator.suggestions;
    // `foo02` has better relevance, its type matches the context type
    suggestionsValidator.assertCompletions(['foo02', 'foo01']);
  }

  Future<void> _configureWithWorkspaceRoot() async {
    await setRoots(included: [workspaceRootPath], excluded: []);
    await server.onAnalysisComplete;
  }

  Future<CompletionGetSuggestions2ResponseValidator> _getSuggestions({
    required String path,
    required int completionOffset,
    required int maxResults,
  }) async {
    var request = CompletionGetSuggestions2Params(
      path,
      completionOffset,
      maxResults,
    ).toRequest('0');

    var response = await _handleSuccessfulRequest(request);
    var result = CompletionGetSuggestions2Result.fromResponse(response);
    return CompletionGetSuggestions2ResponseValidator(completionOffset, result);
  }

  Future<CompletionGetSuggestions2ResponseValidator> _getTestCodeSuggestions(
    String content, {
    int maxResults = 1 << 10,
  }) async {
    var completionOffset = content.indexOf('^');
    expect(completionOffset, isNot(equals(-1)), reason: 'missing ^');

    var nextOffset = content.indexOf('^', completionOffset + 1);
    expect(nextOffset, equals(-1), reason: 'too many ^');

    var testFile = newFile(testFilePath,
        content: content.substring(0, completionOffset) +
            content.substring(completionOffset + 1));

    return await _getSuggestions(
      path: testFile.path,
      completionOffset: completionOffset,
      maxResults: maxResults,
    );
  }

  /// Validates that the given [request] is handled successfully.
  Future<Response> _handleSuccessfulRequest(Request request) async {
    var response = await serverChannel.sendRequest(request);
    expect(response, isResponseSuccess(request.id));
    return response;
  }
}

@reflectiveTest
class CompletionDomainHandlerGetSuggestionsTest
    extends AbstractCompletionDomainTest {
  Future<void> test_ArgumentList_constructor_named_fieldFormalParam() async {
    // https://github.com/dart-lang/sdk/issues/31023
    addTestFile('''
void f() { new A(field: ^);}
class A {
  A({this.field: -1}) {}
}
''');
    await getSuggestions();
  }

  Future<void> test_ArgumentList_constructor_named_param_label() async {
    addTestFile('void f() { new A(^);}'
        'class A { A({one, two}) {} }');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'one: ');
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'two: ');
    expect(suggestions, hasLength(2));
  }

  Future<void> test_ArgumentList_factory_named_param_label() async {
    addTestFile('void f() { new A(^);}'
        'class A { factory A({one, two}) => throw 0; }');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'one: ');
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'two: ');
    expect(suggestions, hasLength(2));
  }

  Future<void>
      test_ArgumentList_function_named_fromPositionalNumeric_withoutSpace() async {
    addTestFile('void f(int a, {int b = 0}) {}'
        'void g() { f(2, ^3); }');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'b: ');
    expect(suggestions, hasLength(1));
    // Ensure we don't try to replace the following arg.
    expect(replacementOffset, equals(completionOffset));
    expect(replacementLength, equals(0));
  }

  Future<void>
      test_ArgumentList_function_named_fromPositionalNumeric_withSpace() async {
    addTestFile('void f(int a, {int b = 0}) {}'
        'void g() { f(2, ^ 3); }');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'b: ');
    expect(suggestions, hasLength(1));
    // Ensure we don't try to replace the following arg.
    expect(replacementOffset, equals(completionOffset));
    expect(replacementLength, equals(0));
  }

  Future<void>
      test_ArgumentList_function_named_fromPositionalVariable_withoutSpace() async {
    addTestFile('void f(int a, {int b = 0}) {}'
        'var foo = 1;'
        'void g() { f(2, ^foo); }');
    await getSuggestions();
    expect(suggestions, hasLength(1));

    // The named arg "b: " should not replace anything.
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'b: ',
        replacementOffset: null, replacementLength: 0);
  }

  Future<void>
      test_ArgumentList_function_named_fromPositionalVariable_withSpace() async {
    addTestFile('void f(int a, {int b = 0}) {}'
        'var foo = 1;'
        'void g() { f(2, ^ foo); }');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'b: ');
    expect(suggestions, hasLength(1));
    // Ensure we don't try to replace the following arg.
    expect(replacementOffset, equals(completionOffset));
    expect(replacementLength, equals(0));
  }

  Future<void> test_ArgumentList_function_named_partiallyTyped() async {
    addTestFile('''
    class C {
      void m(String firstString, {String secondString}) {}

      void n() {
        m('a', se^'b');
      }
    }
    ''');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'secondString: ');
    expect(suggestions, hasLength(1));
    // Ensure we replace the correct section.
    expect(replacementOffset, equals(completionOffset - 2));
    expect(replacementLength, equals(2));
  }

  Future<void> test_ArgumentList_imported_function_named_param() async {
    addTestFile('void f() { int.parse("16", ^);}');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'radix: ');
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'onError: ');
    expect(suggestions, hasLength(2));
  }

  Future<void> test_ArgumentList_imported_function_named_param1() async {
    addTestFile('void f() { foo(o^);} foo({one, two}) {}');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'one: ');
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'two: ');
    expect(suggestions, hasLength(2));
  }

  Future<void> test_ArgumentList_imported_function_named_param2() async {
    addTestFile('void f() {A a = new A(); a.foo(one: 7, ^);}'
        'class A { foo({one, two}) {} }');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'two: ');
    expect(suggestions, hasLength(1));
  }

  Future<void> test_ArgumentList_imported_function_named_param_label1() async {
    addTestFile('void f() { int.parse("16", r^: 16);}');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'radix');
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'onError');
    expect(suggestions, hasLength(2));
  }

  Future<void> test_ArgumentList_imported_function_named_param_label3() async {
    addTestFile('void f() { int.parse("16", ^: 16);}');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'radix: ');
    assertHasResult(CompletionSuggestionKind.NAMED_ARGUMENT, 'onError: ');
    expect(suggestions, hasLength(2));
  }

  Future<void> test_catch() async {
    addTestFile('void f() {try {} ^}');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'on');
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'catch');
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'finally');
    expect(suggestions, hasLength(3));
  }

  Future<void> test_catch2() async {
    addTestFile('void f() {try {} on Foo {} ^}');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'on');
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'catch');
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'finally');
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'for');
    suggestions.firstWhere(
        (CompletionSuggestion suggestion) =>
            suggestion.kind != CompletionSuggestionKind.KEYWORD, orElse: () {
      fail('Expected suggestions other than keyword suggestions');
    });
  }

  Future<void> test_catch3() async {
    addTestFile('void f() {try {} catch (e) {} finally {} ^}');
    await getSuggestions();
    assertNoResult('on');
    assertNoResult('catch');
    assertNoResult('finally');
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'for');
    suggestions.firstWhere(
        (CompletionSuggestion suggestion) =>
            suggestion.kind != CompletionSuggestionKind.KEYWORD, orElse: () {
      fail('Expected suggestions other than keyword suggestions');
    });
  }

  Future<void> test_catch4() async {
    addTestFile('void f() {try {} finally {} ^}');
    await getSuggestions();
    assertNoResult('on');
    assertNoResult('catch');
    assertNoResult('finally');
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'for');
    suggestions.firstWhere(
        (CompletionSuggestion suggestion) =>
            suggestion.kind != CompletionSuggestionKind.KEYWORD, orElse: () {
      fail('Expected suggestions other than keyword suggestions');
    });
  }

  Future<void> test_catch5() async {
    addTestFile('void f() {try {} ^ finally {}}');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'on');
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'catch');
    expect(suggestions, hasLength(2));
  }

  Future<void> test_constructor() async {
    addTestFile('class A {bool foo; A() : ^;}');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'super');
    assertHasResult(CompletionSuggestionKind.INVOCATION, 'foo');
  }

  Future<void> test_constructor2() async {
    addTestFile('class A {bool foo; A() : s^;}');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'super');
    assertHasResult(CompletionSuggestionKind.INVOCATION, 'foo');
  }

  Future<void> test_constructor3() async {
    addTestFile('class A {bool foo; A() : a=7,^;}');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'super');
    assertHasResult(CompletionSuggestionKind.INVOCATION, 'foo');
  }

  Future<void> test_constructor4() async {
    addTestFile('class A {bool foo; A() : a=7,s^;}');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'super');
    assertHasResult(CompletionSuggestionKind.INVOCATION, 'foo');
  }

  Future<void> test_constructor5() async {
    addTestFile('class A {bool foo; A() : a=7,s^}');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'super');
    assertHasResult(CompletionSuggestionKind.INVOCATION, 'foo');
  }

  Future<void> test_constructor6() async {
    addTestFile('class A {bool foo; A() : a=7,^ void bar() {}}');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'super');
    assertHasResult(CompletionSuggestionKind.INVOCATION, 'foo');
  }

  Future<void> test_extension() async {
    addTestFile('''
class MyClass {
  void foo() {
    ba^
  }
}

extension MyClassExtension on MyClass {
  void bar() {}
}
''');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.INVOCATION, 'bar');
  }

  Future<void> test_html() {
    //
    // We no longer support the analysis of non-dart files.
    //
    testFile = convertPath('/project/web/test.html');
    addTestFile('''
      <html>^</html>
    ''');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset));
      expect(replacementLength, equals(0));
      expect(suggestions, hasLength(0));
    });
  }

  Future<void> test_import_uri_with_trailing() {
    final filePath = '/project/bin/testA.dart';
    final incompleteImportText = toUriStr('/project/bin/t');
    newFile(filePath, content: 'library libA;');
    addTestFile('''
    import "$incompleteImportText^.dart";
    void f() {}''');
    return getSuggestions().then((_) {
      expect(replacementOffset,
          equals(completionOffset - incompleteImportText.length));
      expect(replacementLength, equals(5 + incompleteImportText.length));
      assertHasResult(CompletionSuggestionKind.IMPORT, toUriStr(filePath));
      assertNoResult('test');
    });
  }

  Future<void> test_imports() {
    addTestFile('''
      import 'dart:html';
      void f() {^}
    ''');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset));
      expect(replacementLength, equals(0));
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'Object',
          elementKind: ElementKind.CLASS);
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'HtmlElement',
          elementKind: ElementKind.CLASS);
      assertNoResult('test');
    });
  }

  Future<void> test_imports_aborted_new_request() async {
    addTestFile('''
        class foo { }
        c^''');

    // Make a request for suggestions
    var request1 = CompletionGetSuggestionsParams(testFile, completionOffset)
        .toRequest('7');
    var responseFuture1 = waitResponse(request1);

    // Make another request before the first request completes
    var request2 = CompletionGetSuggestionsParams(testFile, completionOffset)
        .toRequest('8');
    var responseFuture2 = waitResponse(request2);

    // Await first response
    var response1 = await responseFuture1;
    var result1 = CompletionGetSuggestionsResult.fromResponse(response1);
    assertValidId(result1.id);

    // Await second response
    var response2 = await responseFuture2;
    var result2 = CompletionGetSuggestionsResult.fromResponse(response2);
    assertValidId(result2.id);

    // Wait for all processing to be complete
    await analysisHandler.server.onAnalysisComplete;
    await pumpEventQueue();

    // Assert that first request has been aborted
    expect(allSuggestions[result1.id], hasLength(0));

    // Assert valid results for the second request
    expect(allSuggestions[result2.id], same(suggestions));
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'class');
  }

  @failingTest
  Future<void> test_imports_aborted_source_changed() async {
    // TODO(brianwilkerson) Figure out whether this test makes sense when
    // running the new driver. It waits for an initial empty notification then
    // waits for a new notification. But I think that under the driver we only
    // ever send one notification.
    addTestFile('''
        class foo { }
        c^''');

    // Make a request for suggestions
    var request = CompletionGetSuggestionsParams(testFile, completionOffset)
        .toRequest('0');
    var responseFuture = waitResponse(request);

    // Simulate user deleting text after request but before suggestions returned
    server.updateContent('uc1', {testFile: AddContentOverlay(testCode)});
    server.updateContent('uc2', {
      testFile: ChangeContentOverlay([SourceEdit(completionOffset - 1, 1, '')])
    });

    // Await a response
    var response = await responseFuture;
    completionId = response.id;
    assertValidId(completionId);

    // Wait for all processing to be complete
    await analysisHandler.server.onAnalysisComplete;
    await pumpEventQueue();

    // Assert that request has been aborted
    expect(suggestionsDone, isTrue);
    expect(suggestions, hasLength(0));
  }

  Future<void> test_imports_incremental() async {
    addTestFile('''library foo;
      e^
      import "dart:async";
      import "package:foo/foo.dart";
      class foo { }''');
    await waitForTasksFinished();
    server.updateContent('uc1', {testFile: AddContentOverlay(testCode)});
    server.updateContent('uc2', {
      testFile: ChangeContentOverlay([SourceEdit(completionOffset, 0, 'xp')])
    });
    completionOffset += 2;
    await getSuggestions();
    expect(replacementOffset, completionOffset - 3);
    expect(replacementLength, 3);
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'export \'\';',
        selectionOffset: 8);
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'import \'\';',
        selectionOffset: 8);
    assertNoResult('extends');
    assertNoResult('library');
  }

  Future<void> test_imports_partial() async {
    addTestFile('''^
      import "package:foo/foo.dart";
      import "package:bar/bar.dart";
      class Baz { }''');

    // Wait for analysis then edit the content
    await waitForTasksFinished();
    var revisedContent = testCode.substring(0, completionOffset) +
        'i' +
        testCode.substring(completionOffset);
    ++completionOffset;
    server.handleRequest(AnalysisUpdateContentParams(
        {testFile: AddContentOverlay(revisedContent)}).toRequest('add1'));

    // Request code completion immediately after edit
    var response = await waitResponse(
        CompletionGetSuggestionsParams(testFile, completionOffset)
            .toRequest('0'));
    completionId = response.id;
    assertValidId(completionId);
    await waitForTasksFinished();
    // wait for response to arrive
    // because although the analysis is complete (waitForTasksFinished)
    // the response may not yet have been processed
    while (replacementOffset == null) {
      await Future.delayed(Duration(milliseconds: 5));
    }
    expect(replacementOffset, completionOffset - 1);
    expect(replacementLength, 1);
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'library');
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'import \'\';',
        selectionOffset: 8);
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'export \'\';',
        selectionOffset: 8);
    assertHasResult(CompletionSuggestionKind.KEYWORD, 'part \'\';',
        selectionOffset: 6);
    assertNoResult('extends');
  }

  Future<void> test_imports_prefixed() {
    addTestFile('''
      import 'dart:html' as foo;
      void f() {^}
    ''');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset));
      expect(replacementLength, equals(0));
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'Object',
          elementKind: ElementKind.CLASS);
      assertHasResult(CompletionSuggestionKind.IDENTIFIER, 'foo');
      assertNoResult('HtmlElement');
      assertNoResult('test');
    });
  }

  Future<void> test_imports_prefixed2() {
    addTestFile('''
      import 'dart:html' as foo;
      void f() {foo.^}
    ''');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset));
      expect(replacementLength, equals(0));
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'HtmlElement');
      assertNoResult('test');
    });
  }

  Future<void> test_inComment_block_beforeNode() async {
    addTestFile('''
  void f(aaa, bbb) {
    /* text ^ */
    print(42);
  }
  ''');
    await getSuggestions();
    expect(suggestions, isEmpty);
  }

  Future<void> test_inComment_endOfFile_withNewline() async {
    addTestFile('''
    // text ^
  ''');
    await getSuggestions();
    expect(suggestions, isEmpty);
  }

  Future<void> test_inComment_endOfFile_withoutNewline() async {
    addTestFile('// text ^');
    await getSuggestions();
    expect(suggestions, isEmpty);
  }

  Future<void> test_inComment_endOfLine_beforeNode() async {
    addTestFile('''
  void f(aaa, bbb) {
    // text ^
    print(42);
  }
  ''');
    await getSuggestions();
    expect(suggestions, isEmpty);
  }

  Future<void> test_inComment_endOfLine_beforeToken() async {
    addTestFile('''
  void f(aaa, bbb) {
    // text ^
  }
  ''');
    await getSuggestions();
    expect(suggestions, isEmpty);
  }

  Future<void> test_inDartDoc1() async {
    addTestFile('''
  /// ^
  void f(aaa, bbb) {}
  ''');
    await getSuggestions();
    expect(suggestions, isEmpty);
  }

  Future<void> test_inDartDoc2() async {
    addTestFile('''
  /// Some text^
  void f(aaa, bbb) {}
  ''');
    await getSuggestions();
    expect(suggestions, isEmpty);
  }

  Future<void> test_inDartDoc3() async {
    addTestFile('''
class MyClass {
  /// ^
  void foo() {}

  void bar() {}
}

extension MyClassExtension on MyClass {
  void baz() {}
}
  ''');
    await getSuggestions();
    expect(suggestions, isEmpty);
  }

  Future<void> test_inDartDoc_reference1() async {
    newFile('/testA.dart', content: '''
  part of libA;
  foo(bar) => 0;''');
    addTestFile('''
  library libA;
  part "${toUriStr('/testA.dart')}";
  import "dart:math";
  /// The [^]
  void f(aaa, bbb) {}
  ''');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.IDENTIFIER, 'f');
    assertHasResult(CompletionSuggestionKind.IDENTIFIER, 'foo');
    assertHasResult(CompletionSuggestionKind.IDENTIFIER, 'min');
  }

  Future<void> test_inDartDoc_reference2() async {
    addTestFile('''
  /// The [m^]
  void f(aaa, bbb) {}
  ''');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.IDENTIFIER, 'f');
  }

  Future<void> test_inDartDoc_reference3() async {
    addTestFile('''
class MyClass {
  /// [^]
  void foo() {}

  void bar() {}
}

extension MyClassExtension on MyClass {
  void baz() {}
}
  ''');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.IDENTIFIER, 'bar');
    assertHasResult(CompletionSuggestionKind.IDENTIFIER, 'baz');
  }

  Future<void> test_inherited() {
    addTestFile('''
class A {
  m() {}
}
class B extends A {
  x() {^}
}
''');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset));
      expect(replacementLength, equals(0));
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'm');
    });
  }

  Future<void> test_invalidFilePathFormat_notAbsolute() async {
    var request = CompletionGetSuggestionsParams('test.dart', 0).toRequest('0');
    var response = await waitResponse(request);
    expect(
      response,
      isResponseFailure('0', RequestErrorCode.INVALID_FILE_PATH_FORMAT),
    );
  }

  Future<void> test_invalidFilePathFormat_notNormalized() async {
    var request =
        CompletionGetSuggestionsParams(convertPath('/foo/../bar/test.dart'), 0)
            .toRequest('0');
    var response = await waitResponse(request);
    expect(
      response,
      isResponseFailure('0', RequestErrorCode.INVALID_FILE_PATH_FORMAT),
    );
  }

  Future<void> test_invocation() {
    addTestFile('class A {b() {}} void f() {A a; a.^}');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset));
      expect(replacementLength, equals(0));
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'b');
    });
  }

  Future<void> test_invocation_withTrailingStmt() {
    addTestFile('class A {b() {}} void f() {A a; a.^ int x = 7;}');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset));
      expect(replacementLength, equals(0));
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'b');
    });
  }

  Future<void> test_is_asPrefixedIdentifierStart() async {
    addTestFile('''
class A { var isVisible;}
void f(A p) { var v1 = p.is^; }''');
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.INVOCATION, 'isVisible');
  }

  Future<void> test_keyword() {
    addTestFile('library A; cl^');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset - 2));
      expect(replacementLength, equals(2));
      assertHasResult(CompletionSuggestionKind.KEYWORD, 'export \'\';',
          selectionOffset: 8);
      assertHasResult(CompletionSuggestionKind.KEYWORD, 'class');
    });
  }

  Future<void> test_local_implicitCreation() async {
    addTestFile('''
class A {
  A();
  A.named();
}
void f() {
  ^
}
''');
    await getSuggestions();

    expect(replacementOffset, equals(completionOffset));
    expect(replacementLength, equals(0));

    // The class is suggested.
    assertHasResult(CompletionSuggestionKind.INVOCATION, 'A',
        elementKind: ElementKind.CLASS);

    // Both constructors - default and named, are suggested.
    assertHasResult(CompletionSuggestionKind.INVOCATION, 'A',
        elementKind: ElementKind.CONSTRUCTOR);
    assertHasResult(CompletionSuggestionKind.INVOCATION, 'A.named',
        elementKind: ElementKind.CONSTRUCTOR);
  }

  Future<void> test_local_named_constructor() {
    addTestFile('class A {A.c(); x() {new A.^}}');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset));
      expect(replacementLength, equals(0));
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'c');
      assertNoResult('A');
    });
  }

  Future<void> test_local_override() {
    newFile('/project/bin/a.dart', content: 'class A {m() {}}');
    addTestFile('''
import 'a.dart';
class B extends A {
  m() {}
  x() {^}
}
''');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset));
      expect(replacementLength, equals(0));
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'm');
    });
  }

  Future<void> test_local_shadowClass() async {
    addTestFile('''
class A {
  A();
  A.named();
}
void f() {
  int A = 0;
  ^
}
''');
    await getSuggestions();

    expect(replacementOffset, equals(completionOffset));
    expect(replacementLength, equals(0));

    // The class is suggested.
    assertHasResult(CompletionSuggestionKind.INVOCATION, 'A');

    // Class and all its constructors are shadowed by the local variable.
    assertNoResult('A', elementKind: ElementKind.CLASS);
    assertNoResult('A', elementKind: ElementKind.CONSTRUCTOR);
    assertNoResult('A.named', elementKind: ElementKind.CONSTRUCTOR);
  }

  Future<void> test_locals() {
    addTestFile('class A {var a; x() {var b;^}} class DateTime { }');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset));
      expect(replacementLength, equals(0));
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'A',
          elementKind: ElementKind.CLASS);
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'a');
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'b');
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'x');
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'DateTime',
          elementKind: ElementKind.CLASS);
    });
  }

  Future<void> test_offset_past_eof() async {
    addTestFile('void f() { }', offset: 300);
    var request = CompletionGetSuggestionsParams(testFile, completionOffset)
        .toRequest('0');
    var response = await waitResponse(request);
    expect(response.id, '0');
    expect(response.error!.code, RequestErrorCode.INVALID_PARAMETER);
  }

  Future<void> test_overrides() {
    newFile('/project/bin/a.dart', content: 'class A {m() {}}');
    addTestFile('''
import 'a.dart';
class B extends A {m() {^}}
''');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset));
      expect(replacementLength, equals(0));
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'm');
    });
  }

  Future<void> test_partFile() {
    newFile('/project/bin/a.dart', content: '''
      library libA;
      import 'dart:html';
      part 'test.dart';
      class A { }
    ''');
    addTestFile('''
      part of libA;
      void f() {^}''');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset));
      expect(replacementLength, equals(0));
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'Object',
          elementKind: ElementKind.CLASS);
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'HtmlElement',
          elementKind: ElementKind.CLASS);
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'A',
          elementKind: ElementKind.CLASS);
      assertNoResult('test');
    });
  }

  Future<void> test_partFile2() {
    newFile('/project/bin/a.dart', content: '''
      part of libA;
      class A { }''');
    addTestFile('''
      library libA;
      part "a.dart";
      import 'dart:html';
      void f() {^}
    ''');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset));
      expect(replacementLength, equals(0));
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'Object',
          elementKind: ElementKind.CLASS);
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'HtmlElement',
          elementKind: ElementKind.CLASS);
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'A',
          elementKind: ElementKind.CLASS);
      assertNoResult('test');
    });
  }

  Future<void> test_sentToPlugins() async {
    addTestFile('''
      void f() {
        ^
      }
    ''');
    PluginInfo info = DiscoveredPluginInfo('a', 'b', 'c',
        TestNotificationManager(), InstrumentationService.NULL_SERVICE);
    var result = plugin.CompletionGetSuggestionsResult(
        testFile.indexOf('^'), 0, <CompletionSuggestion>[
      CompletionSuggestion(CompletionSuggestionKind.IDENTIFIER,
          DART_RELEVANCE_DEFAULT, 'plugin completion', 3, 0, false, false)
    ]);
    pluginManager.broadcastResults = <PluginInfo, Future<plugin.Response>>{
      info: Future.value(result.toResponse('-', 1))
    };
    await getSuggestions();
    assertHasResult(CompletionSuggestionKind.IDENTIFIER, 'plugin completion',
        selectionOffset: 3);
  }

  Future<void> test_simple() {
    addTestFile('''
      void f() {
        ^
      }
    ''');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset));
      expect(replacementLength, equals(0));
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'Object',
          elementKind: ElementKind.CLASS);
      assertNoResult('HtmlElement');
      assertNoResult('test');
    });
  }

  Future<void> test_static() async {
    addTestFile('class A {static b() {} c() {}} void f() {A.^}');
    await getSuggestions();
    expect(replacementOffset, equals(completionOffset));
    expect(replacementLength, equals(0));
    assertHasResult(CompletionSuggestionKind.INVOCATION, 'b');
    assertNoResult('c');
  }

  Future<void> test_topLevel() {
    addTestFile('''
      typedef foo();
      var test = '';
      void f() {tes^t}
    ''');
    return getSuggestions().then((_) {
      expect(replacementOffset, equals(completionOffset - 3));
      expect(replacementLength, equals(4));
      // Suggestions based upon imported elements are partially filtered
      //assertHasResult(CompletionSuggestionKind.INVOCATION, 'Object');
      assertHasResult(CompletionSuggestionKind.INVOCATION, 'test');
      assertNoResult('HtmlElement');
    });
  }
}

class CompletionGetSuggestions2ResponseValidator {
  final int completionOffset;
  final CompletionGetSuggestions2Result result;

  CompletionGetSuggestions2ResponseValidator(
    this.completionOffset,
    this.result,
  );

  SuggestionsValidator get suggestions {
    return SuggestionsValidator(result.suggestions);
  }

  void assertEmptyReplacement() {
    assertReplacement(completionOffset, 0);
  }

  void assertReplacement(int offset, int length) {
    expect(result.replacementOffset, offset);
    expect(result.replacementLength, length);
  }

  void assertReplacementBack(int length) {
    assertReplacement(completionOffset - length, length);
  }
}

class SingleSuggestionValidator {
  final CompletionSuggestion suggestion;

  SingleSuggestionValidator(this.suggestion);

  void assertClass() {
    expect(suggestion.kind, CompletionSuggestionKind.INVOCATION);
    expect(suggestion.element?.kind, ElementKind.CLASS);
  }

  void assertConstructor() {
    expect(suggestion.kind, CompletionSuggestionKind.INVOCATION);
    expect(suggestion.element?.kind, ElementKind.CONSTRUCTOR);
  }

  void assertGetter() {
    expect(suggestion.kind, CompletionSuggestionKind.INVOCATION);
    expect(suggestion.element?.kind, ElementKind.GETTER);
  }

  void assertMethod() {
    expect(suggestion.kind, CompletionSuggestionKind.INVOCATION);
    expect(suggestion.element?.kind, ElementKind.METHOD);
  }

  void assertTopLevelVariable() {
    expect(suggestion.kind, CompletionSuggestionKind.INVOCATION);
    expect(suggestion.element?.kind, ElementKind.TOP_LEVEL_VARIABLE);
  }
}

class SuggestionsValidator {
  final List<CompletionSuggestion> suggestions;

  SuggestionsValidator(this.suggestions);

  int get length => suggestions.length;

  /// Assert that this has suggestions with exactly the given completions,
  /// with the exact order.
  ///
  /// Does not check suggestion kinds, elements, etc.
  void assertCompletions(Iterable<String> completions) {
    var actual = suggestions.map((e) => e.completion).toList();
    expect(actual, completions);
  }

  void assertEmpty() {
    expect(suggestions, isEmpty);
  }

  void assertLength(Object matcher) {
    expect(suggestions, hasLength(matcher));
  }

  SingleSuggestionValidator assertSingle() {
    assertLength(1);
    return SingleSuggestionValidator(suggestions.single);
  }

  SuggestionsValidator withCompletion(String completion) {
    return SuggestionsValidator(
      suggestions.where((suggestion) {
        return suggestion.completion == completion;
      }).toList(),
    );
  }

  SuggestionsValidator withElementClass() {
    return withElementKind(ElementKind.CLASS);
  }

  SuggestionsValidator withElementConstructor() {
    return withElementKind(ElementKind.CONSTRUCTOR);
  }

  SuggestionsValidator withElementKind(ElementKind kind) {
    return SuggestionsValidator(
      suggestions.where((suggestion) {
        return suggestion.element?.kind == kind;
      }).toList(),
    );
  }
}
