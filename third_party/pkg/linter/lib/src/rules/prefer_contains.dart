// Copyright (c) 2016, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../analyzer.dart';
import '../util/dart_type_utilities.dart';

const alwaysFalse =
    'Always false because indexOf is always greater or equal -1.';

const alwaysTrue = 'Always true because indexOf is always greater or equal -1.';

const useContains = 'Use contains instead of indexOf';
const _desc = r'Use contains for `List` and `String` instances.';

const _details = r'''

**DON'T** use `indexOf` to see if a collection contains an element.

Calling `indexOf` to see if a collection contains something is difficult to read
and may have poor performance.

Instead, prefer `contains`.

**GOOD:**
```dart
if (!lunchBox.contains('sandwich')) return 'so hungry...';
```

**BAD:**
```dart
if (lunchBox.indexOf('sandwich')) == -1 return 'so hungry...';
```

''';

class PreferContainsOverIndexOf extends LintRule implements NodeLintRule {
  PreferContainsOverIndexOf()
      : super(
            name: 'prefer_contains',
            description: _desc,
            details: _details,
            group: Group.style);

  @override
  void registerNodeProcessors(
      NodeLintRegistry registry, LinterContext context) {
    var visitor = _Visitor(this, context);
    registry.addMethodInvocation(this, visitor);
  }

  void reportLintWithDescription(AstNode? node, String description) {
    if (node != null) {
      reporter.reportErrorForNode(_LintCode(name, description), node, []);
    }
  }
}

/// TODO create common MultiMessageLintCode class
class _LintCode extends LintCode {
  static final registry = <String, _LintCode>{};

  factory _LintCode(String name, String message) =>
      registry.putIfAbsent(name + message, () => _LintCode._(name, message));

  _LintCode._(String name, String message) : super(name, message);
}

class _Visitor extends SimpleAstVisitor<void> {
  final PreferContainsOverIndexOf rule;

  final LinterContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.methodName.name != 'indexOf') {
      return;
    }

    var parentType = node.target?.staticType;
    if (parentType == null ||
        !DartTypeUtilities.implementsAnyInterface(parentType, [
          InterfaceTypeDefinition('Iterable', 'dart.core'),
          InterfaceTypeDefinition('String', 'dart.core'),
        ])) {
      return;
    }

    if (node.parent is AssignmentExpression) {
      // The result of `indexOf` is being assigned before being compared, so
      // it's important. E.g.  `(next = list.indexOf('{')) != -1)`.
      return;
    }

    // Going up in AST structure to find binary comparison operator for this
    // `indexOf` access. Most of the time it will be a parent, but sometimes
    // it can be wrapped in parentheses or `as` operator.
    AstNode? search = node;
    while (
        search != null && search is Expression && search is! BinaryExpression) {
      search = search.parent;
    }

    if (search is! BinaryExpression) {
      return;
    }

    var binaryExpression = search;
    var operator = binaryExpression.operator;

    // Comparing constants with result of indexOf.

    var rightOperand = binaryExpression.rightOperand;
    var rightValue = context.evaluateConstant(rightOperand).value;

    if (rightValue != null && (rightValue.type?.isDartCoreInt ?? false)) {
      // Constant is on right side of comparison operator
      _checkConstant(binaryExpression, rightValue.toIntValue(), operator.type);
      return;
    }

    var leftOperand = binaryExpression.leftOperand;
    var leftValue = context.evaluateConstant(leftOperand).value;
    if (leftValue != null && (leftValue.type?.isDartCoreInt ?? false)) {
      // Constants is on left side of comparison operator
      _checkConstant(binaryExpression, leftValue.toIntValue(),
          _invertedTokenType(operator.type));
    }
  }

  void _checkConstant(Expression expression, int? value, TokenType type) {
    if (value == -1) {
      if (type == TokenType.EQ_EQ ||
          type == TokenType.BANG_EQ ||
          type == TokenType.LT_EQ ||
          type == TokenType.GT) {
        rule.reportLintWithDescription(expression, useContains);
      } else if (type == TokenType.LT) {
        // indexOf < -1 is always false
        rule.reportLintWithDescription(expression, alwaysFalse);
      } else if (type == TokenType.GT_EQ) {
        // indexOf >= -1 is always true
        rule.reportLintWithDescription(expression, alwaysTrue);
      }
    } else if (value == 0) {
      // 'indexOf >= 0' is same as 'contains',
      // and 'indexOf < 0' is same as '!contains'
      if (type == TokenType.GT_EQ || type == TokenType.LT) {
        rule.reportLintWithDescription(expression, useContains);
      }
    } else if (value! < -1) {
      // 'indexOf' is always >= -1, so comparing with lesser values makes
      // no sense.
      if (type == TokenType.EQ_EQ ||
          type == TokenType.LT_EQ ||
          type == TokenType.LT) {
        rule.reportLintWithDescription(expression, alwaysFalse);
      } else if (type == TokenType.BANG_EQ ||
          type == TokenType.GT_EQ ||
          type == TokenType.GT) {
        rule.reportLintWithDescription(expression, alwaysTrue);
      }
    }
  }

  TokenType _invertedTokenType(TokenType type) {
    switch (type) {
      case TokenType.LT_EQ:
        return TokenType.GT_EQ;

      case TokenType.LT:
        return TokenType.GT;

      case TokenType.GT:
        return TokenType.LT;

      case TokenType.GT_EQ:
        return TokenType.LT_EQ;

      default:
        return type;
    }
  }
}
