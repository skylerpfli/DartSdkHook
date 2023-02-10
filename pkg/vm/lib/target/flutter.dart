// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:kernel/ast.dart' show Component, Library;
import 'package:kernel/core_types.dart' show CoreTypes;
import 'package:kernel/target/changed_structure_notifier.dart';
import 'package:kernel/target/targets.dart';
import 'package:kernel/transformations/track_widget_constructor_locations.dart';
import 'package:vm/target/vm.dart' show VmTarget;
import 'dart:convert';
import 'dart:io';
import 'package:kernel/class_hierarchy.dart';
import 'package:kernel/reference_from_index.dart';

abstract class FlutterProgramTransformer {
  void transform(Component component);
}

class FlutterTarget extends VmTarget {
  FlutterTarget(TargetFlags flags) : super(flags);

  late final WidgetCreatorTracker _widgetTracker = WidgetCreatorTracker();

  @override
  String get name => 'flutter';

  @override
  bool get enableSuperMixins => true;

  /// 代码插桩
  static List<FlutterProgramTransformer> _flutterProgramTransformers = [];

  static List<FlutterProgramTransformer> get flutterProgramTransformers => _flutterProgramTransformers;

  /// 在常量处理后插桩
  static List<FlutterProgramTransformer> _transformersAfterConstant = [];

  static List<FlutterProgramTransformer> get transformersAfterConstant => _transformersAfterConstant;

  /// 新增解析文件
  static List<Uri> entryPointList = [];

  // This is the order that bootstrap libraries are loaded according to
  // `runtime/vm/object_store.h`.
  @override
  List<String> get extraRequiredLibraries => const <String>[
        'dart:async',
        'dart:collection',
        'dart:convert',
        'dart:developer',
        'dart:ffi',
        'dart:_internal',
        'dart:isolate',
        'dart:math',

        // The library dart:mirrors may be ignored by the VM, e.g. when built in
        // PRODUCT mode.
        'dart:mirrors',

        'dart:typed_data',
        'dart:nativewrappers',
        'dart:io',

        // Required for flutter.
        'dart:ui',
        'dart:vmservice_io',
      ];

  @override
  List<String> get extraRequiredLibrariesPlatform => const <String>[];

  @override
  void performPreConstantEvaluationTransformations(Component component,
      CoreTypes coreTypes,
      List<Library> libraries,
      DiagnosticReporter diagnosticReporter,
      {void Function(String msg)? logger,
        ChangedStructureNotifier? changedStructureNotifier}) {
    super.performPreConstantEvaluationTransformations(component, coreTypes, libraries, diagnosticReporter, logger: logger, changedStructureNotifier: changedStructureNotifier);
    if (flags.trackWidgetCreation) {
      _widgetTracker.transform(component, libraries, changedStructureNotifier);
    }

    /// 工程插桩
    if (_flutterProgramTransformers.length > 0) {
      int flutterProgramTransformersLen = _flutterProgramTransformers.length;
      for (int i = 0; i < flutterProgramTransformersLen; i++) {
        _flutterProgramTransformers[i].transform(component);
      }
    }
  }

  @override
  void performModularTransformationsOnLibraries(Component component,
      CoreTypes coreTypes,
      ClassHierarchy hierarchy,
      List<Library> libraries,
      Map<String, String>? environmentDefines,
      DiagnosticReporter diagnosticReporter,
      ReferenceFromIndex? referenceFromIndex,
      {void Function(String msg)? logger,
        ChangedStructureNotifier? changedStructureNotifier}) {

    /// 常量后工程插桩
    if (_transformersAfterConstant.length > 0) {
      int flutterProgramTransformersLen = _transformersAfterConstant.length;
      for (int i = 0; i < flutterProgramTransformersLen; i++) {
        _transformersAfterConstant[i].transform(component);
      }
    }

    super.performModularTransformationsOnLibraries(
        component,
        coreTypes,
        hierarchy,
        libraries,
        environmentDefines,
        diagnosticReporter,
        referenceFromIndex,
        logger: logger,
        changedStructureNotifier: changedStructureNotifier);
  }
}
