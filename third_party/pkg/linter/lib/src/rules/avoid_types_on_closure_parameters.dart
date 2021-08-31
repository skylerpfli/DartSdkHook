// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../analyzer.dart';

const _desc = r'Avoid annotating types for function expression parameters.';

const _details = r'''

**AVOID** annotating types for function expression parameters.

Annotating types for function expression parameters is usually unnecessary
because the parameter types can almost always be inferred from the context,
thus making the practice redundant.

**BAD:**
```
var names = people.map((Person person) => person.name);
```

**GOOD:**
```
var names = people.map((person) => person.name);
```

''';

class AvoidTypesOnClosureParameters extends LintRule implements NodeLintRule {
  AvoidTypesOnClosureParameters()
      : super(
            name: 'avoid_types_on_closure_parameters',
            description: _desc,
            details: _details,
            group: Group.style);

  @override
  void registerNodeProcessors(
      NodeLintRegistry registry, LinterContext context) {
    final visitor = _Visitor(this);
    registry.addFunctionExpression(this, visitor);
  }
}

class AvoidTypesOnClosureParametersVisitor extends SimpleAstVisitor {
  LintRule rule;

  AvoidTypesOnClosureParametersVisitor(this.rule);

  @override
  void visitDefaultFormalParameter(DefaultFormalParameter node) {
    node.parameter.accept(this);
  }

  @override
  void visitFunctionExpression(FunctionExpression node) {
    if (node.parent is FunctionDeclaration) {
      return;
    }
    for (final parameter in node.parameters.parameters) {
      parameter.accept(this);
    }
  }

  @override
  void visitFunctionTypedFormalParameter(FunctionTypedFormalParameter node) {
    rule.reportLint(node);
  }

  @override
  void visitSimpleFormalParameter(SimpleFormalParameter node) {
    final type = node.type;
    if (type is TypeName && type.name.name != 'dynamic') {
      rule.reportLint(node.type);
    }
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final LintRule rule;

  _Visitor(this.rule);

  @override
  void visitFunctionExpression(FunctionExpression node) {
    final visitor = AvoidTypesOnClosureParametersVisitor(rule);
    visitor.visitFunctionExpression(node);
  }
}
