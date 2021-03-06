// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

import 'package:analysis_server/src/computer/computer_hover.dart';
import 'package:analysis_server/src/protocol_server.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/ast/element_locator.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';
import 'package:analyzer/src/dartdoc/dartdoc_directive_info.dart';

/// A computer for the signature at the specified offset of a Dart
/// [CompilationUnit].
class DartUnitSignatureComputer {
  final DartdocDirectiveInfo _dartdocInfo;
  final AstNode _node;
  ArgumentList _argumentList;
  DartUnitSignatureComputer(
      this._dartdocInfo, CompilationUnit _unit, int _offset)
      : _node = NodeLocator(_offset).searchWithin(_unit);

  /// The [ArgumentList] node located by [compute].
  ArgumentList get argumentList => _argumentList;

  bool get offsetIsValid => _node != null;

  /// Returns the computed signature information, maybe `null`.
  AnalysisGetSignatureResult compute() {
    if (_node == null) {
      return null;
    }

    // Find the closest argument list.
    var argsNode = _node;
    while (argsNode != null && !(argsNode is ArgumentList)) {
      // Certain nodes don't make sense to search above for an argument list
      // (for example when inside a function epxression).
      if (argsNode is FunctionExpression) {
        return null;
      }
      argsNode = argsNode.parent;
    }

    if (argsNode == null) {
      return null;
    }

    final args = argsNode;
    String name;
    ExecutableElement execElement;
    final parent = args.parent;
    if (parent is MethodInvocation) {
      name = parent.methodName.name;
      var element = ElementLocator.locate(parent);
      execElement = element is ExecutableElement ? element : null;
    } else if (parent is InstanceCreationExpression) {
      name = parent.constructorName.type.name.name;
      if (parent.constructorName.name != null) {
        name += '.${parent.constructorName.name.name}';
      }
      execElement = ElementLocator.locate(parent) as ExecutableElement;
    }

    if (execElement == null) {
      return null;
    }

    _argumentList = args;

    final parameters =
        execElement.parameters.map((p) => _convertParam(p)).toList();

    return AnalysisGetSignatureResult(name, parameters,
        dartdoc: DartUnitHoverComputer.computeDocumentation(
            _dartdocInfo, execElement));
  }

  ParameterInfo _convertParam(ParameterElement param) {
    return ParameterInfo(
        param.isOptionalNamed
            ? ParameterKind.OPTIONAL_NAMED
            : param.isOptionalPositional
                ? ParameterKind.OPTIONAL_POSITIONAL
                : param.isRequiredNamed
                    ? ParameterKind.REQUIRED_NAMED
                    : ParameterKind.REQUIRED_POSITIONAL,
        param.displayName,
        param.type.getDisplayString(withNullability: false),
        defaultValue: param.defaultValueCode);
  }
}
