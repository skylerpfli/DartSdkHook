// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.10

import 'dart:io';

import 'package:expect/expect.dart';
import 'package:compiler/compiler_api.dart' as api;
import 'package:dart_style/dart_style.dart' show DartFormatter;
import '../../helpers/memory_compiler.dart';
import '../../../tool/graph_isomorphizer.dart';

/// Only generate goldens from the root sdk directory.
const String goldenDirectory =
    'pkg/compiler/test/tool/graph_isomorphizer/golden';

/// A map of folder name to graph file lines. When adding new tests, its
/// probably best to get the ordering of these lines from the compiler.
const Map<String, List<String>> testCases = {
  'simple': ['100', '010', '001', '101', '011', '111'],
  'less_simple': [
    '1000',
    '0100',
    '0010',
    '0001',
    '1100',
    '0101',
    '1011',
    '0111',
    '1111'
  ]
};

void unorderedListEquals(List<String> expected, List<String> actual) {
  var sortedExpected = expected.toList();
  var sortedActual = actual.toList();
  sortedExpected.sort();
  sortedActual.sort();
  Expect.listEquals(sortedExpected, sortedActual);
}

void verifyGeneratedFile(
    String filename, StringBuffer contents, Map<String, String> expectations) {
  Expect.stringEquals(
      DartFormatter().format(contents.toString()), expectations[filename]);
}

GraphIsomorphizer generateFiles(List<String> graphFileLines,
    {String outDirectory: '.'}) {
  Map<int, List<List<int>>> names = {};
  int maxBit = namesFromGraphFileLines(graphFileLines, names);
  var graphIsomorphizer =
      GraphIsomorphizer(names, maxBit, outDirectory: outDirectory);
  graphIsomorphizer.generateFiles();
  return graphIsomorphizer;
}

/// Tests isomorphicity of the code generated by the GraphIsomorphizer.
void verifyGraphFileLines(
    List<String> graphFileLines, Map<String, String> expectations) async {
  // Generate files.
  var graphIsomorphizer = generateFiles(graphFileLines);

  // Verify generated files.
  verifyGeneratedFile(graphIsomorphizer.mainFilename,
      graphIsomorphizer.mainBuffer, expectations);
  verifyGeneratedFile(graphIsomorphizer.rootImportFilename,
      graphIsomorphizer.rootImportBuffer, expectations);
  graphIsomorphizer.entryLibBuffers.forEach((filename, contents) {
    verifyGeneratedFile(filename, contents, expectations);
  });
  graphIsomorphizer.mixerLibBuffers.forEach((filename, contents) {
    verifyGeneratedFile(filename, contents, expectations);
  });

  // Compile generated code and dump deferred graph shape.
  var collector = new OutputCollector();
  await runCompiler(
      memorySourceFiles: expectations,
      options: ['--dump-deferred-graph=deferred_graph.txt'],
      outputProvider: collector);
  var actual = collector
      .getOutput("deferred_graph.txt", api.OutputType.debug)
      .split('\n');

  // Confirm new graph is isomorphic.
  unorderedListEquals(graphFileLines, actual);
}

void generateGoldens() {
  testCases.forEach((name, test) {
    var graphIsomorphizer =
        generateFiles(test, outDirectory: goldenDirectory + '/' + name);
    graphIsomorphizer.writeFiles();
  });
}

String getFilename(String path) {
  var lastSlash = path.lastIndexOf('/');
  return path.substring(lastSlash + 1, path.length);
}

void verifyGoldens() {
  testCases.forEach((name, test) {
    Map<String, String> expectations = {};
    var golden = Directory(goldenDirectory + '/' + name);
    var files = golden.listSync();
    for (var file in files) {
      assert(file is File);
      var contents = (file as File).readAsStringSync();
      var filename = getFilename(file.path);
      expectations[filename] = contents;
    }
    verifyGraphFileLines(test, expectations);
  });
}

void main(List<String> args) {
  bool generate = false;
  for (var arg in args) {
    if (arg == '-g') {
      generate = true;
    }
  }

  if (generate) {
    generateGoldens();
  } else {
    verifyGoldens();
  }
}
