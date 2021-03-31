// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9
//
// This file has been automatically generated. Please do not edit it manually.
// To regenerate the file, use the script
// "pkg/analysis_server/tool/completion_metrics/relevance_table_generator.dart",
// passing it the location of a corpus of code that is large enough for the
// computed values to be statistically meaningful.

import 'package:analysis_server/src/services/completion/dart/probability_range.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';

const defaultElementKindRelevance = {
  'Annotation_name': {
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.000, upper: 0.041),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.041, upper: 1.000),
  },
  'ArgumentList_annotation_named': {
    ElementKind.METHOD: ProbabilityRange(lower: 0.000, upper: 0.026),
    ElementKind.CLASS: ProbabilityRange(lower: 0.026, upper: 0.060),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.060, upper: 0.159),
  },
  'ArgumentList_annotation_unnamed': {
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.375, upper: 1.000),
  },
  'ArgumentList_constructorRedirect_named': {
    ElementKind.METHOD: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.FIELD: ProbabilityRange(lower: 0.008, upper: 0.011),
    ElementKind.ENUM: ProbabilityRange(lower: 0.011, upper: 0.014),
    ElementKind.CLASS: ProbabilityRange(lower: 0.014, upper: 0.017),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.017, upper: 0.031),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.031, upper: 1.000),
  },
  'ArgumentList_constructorRedirect_unnamed': {
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.000, upper: 0.003),
    ElementKind.FIELD: ProbabilityRange(lower: 0.003, upper: 0.005),
    ElementKind.METHOD: ProbabilityRange(lower: 0.011, upper: 0.016),
    ElementKind.ENUM: ProbabilityRange(lower: 0.016, upper: 0.024),
    ElementKind.CLASS: ProbabilityRange(lower: 0.041, upper: 0.062),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.062, upper: 0.122),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.122, upper: 1.000),
  },
  'ArgumentList_constructor_named': {
    ElementKind.METHOD: ProbabilityRange(lower: 0.000, upper: 0.002),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.002, upper: 0.004),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.007, upper: 0.011),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.042, upper: 0.059),
    ElementKind.ENUM: ProbabilityRange(lower: 0.059, upper: 0.082),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.082, upper: 0.135),
    ElementKind.FIELD: ProbabilityRange(lower: 0.135, upper: 0.192),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.192, upper: 0.321),
    ElementKind.CLASS: ProbabilityRange(lower: 0.321, upper: 0.492),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.492, upper: 1.000),
  },
  'ArgumentList_constructor_unnamed': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.001, upper: 0.004),
    ElementKind.METHOD: ProbabilityRange(lower: 0.020, upper: 0.031),
    ElementKind.ENUM: ProbabilityRange(lower: 0.049, upper: 0.070),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.070, upper: 0.095),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.124, upper: 0.162),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.162, upper: 0.255),
    ElementKind.FIELD: ProbabilityRange(lower: 0.255, upper: 0.351),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.351, upper: 0.539),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.539, upper: 0.768),
    ElementKind.CLASS: ProbabilityRange(lower: 0.768, upper: 1.000),
  },
  'ArgumentList_function_named': {
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.038, upper: 0.077),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.077, upper: 0.154),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.154, upper: 0.500),
    ElementKind.FIELD: ProbabilityRange(lower: 0.500, upper: 1.000),
  },
  'ArgumentList_function_unnamed': {
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.003, upper: 0.005),
    ElementKind.METHOD: ProbabilityRange(lower: 0.010, upper: 0.016),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.024, upper: 0.032),
    ElementKind.ENUM: ProbabilityRange(lower: 0.041, upper: 0.052),
    ElementKind.CLASS: ProbabilityRange(lower: 0.052, upper: 0.074),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.074, upper: 0.103),
    ElementKind.FIELD: ProbabilityRange(lower: 0.171, upper: 0.246),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.246, upper: 0.519),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.519, upper: 1.000),
  },
  'ArgumentList_method_named': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.002, upper: 0.005),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.005, upper: 0.011),
    ElementKind.METHOD: ProbabilityRange(lower: 0.011, upper: 0.017),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.017, upper: 0.033),
    ElementKind.ENUM: ProbabilityRange(lower: 0.033, upper: 0.055),
    ElementKind.CLASS: ProbabilityRange(lower: 0.114, upper: 0.209),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.209, upper: 0.306),
    ElementKind.FIELD: ProbabilityRange(lower: 0.306, upper: 0.417),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.417, upper: 0.564),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.760, upper: 1.000),
  },
  'ArgumentList_method_unnamed': {
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.002, upper: 0.004),
    ElementKind.ENUM: ProbabilityRange(lower: 0.025, upper: 0.035),
    ElementKind.METHOD: ProbabilityRange(lower: 0.035, upper: 0.047),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.060, upper: 0.096),
    ElementKind.CLASS: ProbabilityRange(lower: 0.096, upper: 0.138),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.138, upper: 0.188),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.188, upper: 0.279),
    ElementKind.FIELD: ProbabilityRange(lower: 0.279, upper: 0.422),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.422, upper: 0.601),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.601, upper: 1.000),
  },
  'ArgumentList_widgetConstructor_named': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.006, upper: 0.009),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.019, upper: 0.031),
    ElementKind.METHOD: ProbabilityRange(lower: 0.047, upper: 0.066),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.066, upper: 0.093),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.138, upper: 0.187),
    ElementKind.ENUM: ProbabilityRange(lower: 0.187, upper: 0.273),
    ElementKind.FIELD: ProbabilityRange(lower: 0.273, upper: 0.361),
    ElementKind.CLASS: ProbabilityRange(lower: 0.361, upper: 0.482),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.482, upper: 1.000),
  },
  'ArgumentList_widgetConstructor_unnamed': {
    ElementKind.ENUM: ProbabilityRange(lower: 0.004, upper: 0.008),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.008, upper: 0.012),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.018, upper: 0.029),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.029, upper: 0.040),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.040, upper: 0.057),
    ElementKind.METHOD: ProbabilityRange(lower: 0.057, upper: 0.087),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.087, upper: 0.179),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.179, upper: 0.307),
    ElementKind.FIELD: ProbabilityRange(lower: 0.307, upper: 0.555),
    ElementKind.CLASS: ProbabilityRange(lower: 0.555, upper: 1.000),
  },
  'AsExpression_type': {
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.ENUM: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.001, upper: 0.002),
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.002, upper: 0.012),
    ElementKind.CLASS: ProbabilityRange(lower: 0.012, upper: 1.000),
  },
  'AssertInitializer_condition': {
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.000, upper: 1.000),
  },
  'AssertInitializer_message': {
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.000, upper: 1.000),
  },
  'AssertStatement_condition': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.002, upper: 0.004),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.009, upper: 0.015),
    ElementKind.METHOD: ProbabilityRange(lower: 0.015, upper: 0.054),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.054, upper: 0.110),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.166, upper: 0.292),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.292, upper: 0.617),
    ElementKind.FIELD: ProbabilityRange(lower: 0.617, upper: 1.000),
  },
  'AssertStatement_message': {
    ElementKind.METHOD: ProbabilityRange(lower: 0.000, upper: 1.000),
  },
  'AssignmentExpression_rightHandSide': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.002),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.005, upper: 0.016),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.016, upper: 0.029),
    ElementKind.METHOD: ProbabilityRange(lower: 0.029, upper: 0.043),
    ElementKind.ENUM: ProbabilityRange(lower: 0.066, upper: 0.090),
    ElementKind.CLASS: ProbabilityRange(lower: 0.233, upper: 0.287),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.287, upper: 0.400),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.400, upper: 0.533),
    ElementKind.FIELD: ProbabilityRange(lower: 0.533, upper: 0.689),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.689, upper: 1.000),
  },
  'AwaitExpression_expression': {
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.009, upper: 0.019),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.019, upper: 0.046),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.046, upper: 0.083),
    ElementKind.METHOD: ProbabilityRange(lower: 0.083, upper: 0.178),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.178, upper: 0.327),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.327, upper: 0.485),
    ElementKind.CLASS: ProbabilityRange(lower: 0.485, upper: 0.645),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.645, upper: 0.808),
    ElementKind.FIELD: ProbabilityRange(lower: 0.808, upper: 1.000),
  },
  'BinaryExpression_!=_rightOperand': {
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.METHOD: ProbabilityRange(lower: 0.001, upper: 0.001),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.007, upper: 0.010),
    ElementKind.CLASS: ProbabilityRange(lower: 0.010, upper: 0.022),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.022, upper: 0.040),
    ElementKind.ENUM: ProbabilityRange(lower: 0.040, upper: 0.059),
    ElementKind.FIELD: ProbabilityRange(lower: 0.059, upper: 0.094),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.094, upper: 0.140),
  },
  'BinaryExpression_%_rightOperand': {
    ElementKind.ENUM: ProbabilityRange(lower: 0.000, upper: 0.012),
    ElementKind.MIXIN: ProbabilityRange(lower: 0.012, upper: 0.035),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.035, upper: 0.094),
    ElementKind.CLASS: ProbabilityRange(lower: 0.094, upper: 0.188),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.188, upper: 0.306),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.306, upper: 0.529),
    ElementKind.FIELD: ProbabilityRange(lower: 0.529, upper: 1.000),
  },
  'BinaryExpression_&&_rightOperand': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.METHOD: ProbabilityRange(lower: 0.005, upper: 0.010),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.010, upper: 0.018),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.018, upper: 0.029),
    ElementKind.CLASS: ProbabilityRange(lower: 0.029, upper: 0.045),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.045, upper: 0.181),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.181, upper: 0.382),
    ElementKind.FIELD: ProbabilityRange(lower: 0.382, upper: 1.000),
  },
  'BinaryExpression_&_rightOperand': {
    ElementKind.CLASS: ProbabilityRange(lower: 0.023, upper: 0.068),
    ElementKind.FIELD: ProbabilityRange(lower: 0.068, upper: 0.205),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.205, upper: 0.341),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.341, upper: 0.614),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.614, upper: 1.000),
  },
  'BinaryExpression_*_rightOperand': {
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.004, upper: 0.010),
    ElementKind.METHOD: ProbabilityRange(lower: 0.010, upper: 0.018),
    ElementKind.CLASS: ProbabilityRange(lower: 0.018, upper: 0.041),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.041, upper: 0.081),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.081, upper: 0.136),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.136, upper: 0.214),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.214, upper: 0.344),
    ElementKind.FIELD: ProbabilityRange(lower: 0.344, upper: 0.658),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.658, upper: 1.000),
  },
  'BinaryExpression_+_rightOperand': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.003),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.007, upper: 0.012),
    ElementKind.METHOD: ProbabilityRange(lower: 0.012, upper: 0.025),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.025, upper: 0.056),
    ElementKind.CLASS: ProbabilityRange(lower: 0.056, upper: 0.104),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.104, upper: 0.156),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.156, upper: 0.396),
    ElementKind.FIELD: ProbabilityRange(lower: 0.396, upper: 0.655),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.655, upper: 1.000),
  },
  'BinaryExpression_-_rightOperand': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.001, upper: 0.005),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.005, upper: 0.010),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.010, upper: 0.014),
    ElementKind.METHOD: ProbabilityRange(lower: 0.021, upper: 0.038),
    ElementKind.CLASS: ProbabilityRange(lower: 0.038, upper: 0.068),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.068, upper: 0.120),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.120, upper: 0.295),
    ElementKind.FIELD: ProbabilityRange(lower: 0.295, upper: 0.619),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.619, upper: 1.000),
  },
  'BinaryExpression_/_rightOperand': {
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.000, upper: 0.002),
    ElementKind.METHOD: ProbabilityRange(lower: 0.002, upper: 0.004),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.006, upper: 0.017),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.017, upper: 0.042),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.042, upper: 0.075),
    ElementKind.CLASS: ProbabilityRange(lower: 0.075, upper: 0.112),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.112, upper: 0.268),
    ElementKind.FIELD: ProbabilityRange(lower: 0.268, upper: 0.624),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.624, upper: 1.000),
  },
  'BinaryExpression_<<_rightOperand': {
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.167),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.167, upper: 0.500),
    ElementKind.FIELD: ProbabilityRange(lower: 0.500, upper: 1.000),
  },
  'BinaryExpression_<=_rightOperand': {
    ElementKind.CLASS: ProbabilityRange(lower: 0.000, upper: 0.015),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.037, upper: 0.067),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.067, upper: 0.343),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.343, upper: 0.657),
    ElementKind.FIELD: ProbabilityRange(lower: 0.657, upper: 1.000),
  },
  'BinaryExpression_<_rightOperand': {
    ElementKind.ENUM: ProbabilityRange(lower: 0.000, upper: 0.002),
    ElementKind.METHOD: ProbabilityRange(lower: 0.002, upper: 0.005),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.005, upper: 0.007),
    ElementKind.CLASS: ProbabilityRange(lower: 0.023, upper: 0.042),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.042, upper: 0.083),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.083, upper: 0.284),
    ElementKind.FIELD: ProbabilityRange(lower: 0.284, upper: 0.635),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.635, upper: 1.000),
  },
  'BinaryExpression_==_rightOperand': {
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.METHOD: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.001, upper: 0.002),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.008, upper: 0.018),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.055, upper: 0.085),
    ElementKind.CLASS: ProbabilityRange(lower: 0.085, upper: 0.133),
    ElementKind.FIELD: ProbabilityRange(lower: 0.133, upper: 0.183),
    ElementKind.ENUM: ProbabilityRange(lower: 0.183, upper: 0.342),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.342, upper: 0.583),
  },
  'BinaryExpression_>=_rightOperand': {
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.000, upper: 0.006),
    ElementKind.CLASS: ProbabilityRange(lower: 0.018, upper: 0.077),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.077, upper: 0.179),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.179, upper: 0.387),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.387, upper: 0.601),
    ElementKind.FIELD: ProbabilityRange(lower: 0.601, upper: 1.000),
  },
  'BinaryExpression_>>_rightOperand': {
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.000, upper: 1.000),
  },
  'BinaryExpression_>_rightOperand': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.004),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.004, upper: 0.007),
    ElementKind.ENUM: ProbabilityRange(lower: 0.007, upper: 0.014),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.014, upper: 0.029),
    ElementKind.CLASS: ProbabilityRange(lower: 0.068, upper: 0.112),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.112, upper: 0.227),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.227, upper: 0.432),
    ElementKind.FIELD: ProbabilityRange(lower: 0.432, upper: 0.687),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.687, upper: 1.000),
  },
  'BinaryExpression_??_rightOperand': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.METHOD: ProbabilityRange(lower: 0.002, upper: 0.009),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.017, upper: 0.027),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.027, upper: 0.042),
    ElementKind.ENUM: ProbabilityRange(lower: 0.058, upper: 0.083),
    ElementKind.FIELD: ProbabilityRange(lower: 0.108, upper: 0.183),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.183, upper: 0.269),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.367, upper: 0.467),
    ElementKind.CLASS: ProbabilityRange(lower: 0.467, upper: 0.578),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.731, upper: 1.000),
  },
  'BinaryExpression_^_rightOperand': {
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.026),
    ElementKind.FIELD: ProbabilityRange(lower: 0.026, upper: 1.000),
  },
  'BinaryExpression_|_rightOperand': {
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.143),
    ElementKind.FIELD: ProbabilityRange(lower: 0.143, upper: 0.429),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.429, upper: 1.000),
  },
  'BinaryExpression_||_rightOperand': {
    ElementKind.METHOD: ProbabilityRange(lower: 0.004, upper: 0.008),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.008, upper: 0.013),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.018, upper: 0.027),
    ElementKind.CLASS: ProbabilityRange(lower: 0.027, upper: 0.050),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.050, upper: 0.294),
    ElementKind.FIELD: ProbabilityRange(lower: 0.294, upper: 0.618),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.618, upper: 1.000),
  },
  'BinaryExpression_~/_rightOperand': {
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.000, upper: 0.017),
    ElementKind.CLASS: ProbabilityRange(lower: 0.017, upper: 0.050),
    ElementKind.MIXIN: ProbabilityRange(lower: 0.050, upper: 0.083),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.083, upper: 0.183),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.183, upper: 0.467),
    ElementKind.FIELD: ProbabilityRange(lower: 0.467, upper: 1.000),
  },
  'Block_statement': {
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.ENUM: ProbabilityRange(lower: 0.001, upper: 0.001),
    ElementKind.MIXIN: ProbabilityRange(lower: 0.002, upper: 0.003),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.005, upper: 0.006),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.062, upper: 0.077),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.093, upper: 0.116),
    ElementKind.METHOD: ProbabilityRange(lower: 0.171, upper: 0.221),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.221, upper: 0.282),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.282, upper: 0.364),
    ElementKind.CLASS: ProbabilityRange(lower: 0.364, upper: 0.453),
    ElementKind.FIELD: ProbabilityRange(lower: 0.661, upper: 0.802),
  },
  'CatchClause_exceptionType': {
    ElementKind.CLASS: ProbabilityRange(lower: 0.000, upper: 1.000),
  },
  'ClassDeclaration_member': {
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.001, upper: 0.002),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.002, upper: 0.004),
    ElementKind.ENUM: ProbabilityRange(lower: 0.010, upper: 0.015),
    ElementKind.CLASS: ProbabilityRange(lower: 0.442, upper: 1.000),
  },
  'ClassTypeAlias_superclass': {
    ElementKind.CLASS: ProbabilityRange(lower: 0.000, upper: 0.500),
  },
  'CommentReference_identifier': {
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.000, upper: 0.002),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.002, upper: 0.004),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.004, upper: 0.008),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.008, upper: 0.012),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.012, upper: 0.025),
    ElementKind.METHOD: ProbabilityRange(lower: 0.025, upper: 0.060),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.060, upper: 0.118),
    ElementKind.ENUM: ProbabilityRange(lower: 0.118, upper: 0.180),
    ElementKind.FIELD: ProbabilityRange(lower: 0.180, upper: 0.456),
    ElementKind.CLASS: ProbabilityRange(lower: 0.456, upper: 1.000),
  },
  'CompilationUnit_declaration': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.ENUM: ProbabilityRange(lower: 0.001, upper: 0.003),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.024, upper: 0.036),
    ElementKind.CLASS: ProbabilityRange(lower: 0.205, upper: 0.342),
  },
  'ConditionalExpression_elseExpression': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.002, upper: 0.005),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.030, upper: 0.041),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.041, upper: 0.055),
    ElementKind.METHOD: ProbabilityRange(lower: 0.071, upper: 0.096),
    ElementKind.ENUM: ProbabilityRange(lower: 0.096, upper: 0.128),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.128, upper: 0.201),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.201, upper: 0.289),
    ElementKind.FIELD: ProbabilityRange(lower: 0.412, upper: 0.544),
    ElementKind.CLASS: ProbabilityRange(lower: 0.544, upper: 0.722),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.722, upper: 1.000),
  },
  'ConditionalExpression_thenExpression': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.001, upper: 0.004),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.024, upper: 0.034),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.034, upper: 0.048),
    ElementKind.METHOD: ProbabilityRange(lower: 0.069, upper: 0.097),
    ElementKind.ENUM: ProbabilityRange(lower: 0.097, upper: 0.132),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.132, upper: 0.198),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.198, upper: 0.272),
    ElementKind.FIELD: ProbabilityRange(lower: 0.272, upper: 0.367),
    ElementKind.CLASS: ProbabilityRange(lower: 0.513, upper: 0.703),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.703, upper: 1.000),
  },
  'ConstructorDeclaration_initializer': {
    ElementKind.FIELD: ProbabilityRange(lower: 0.181, upper: 0.448),
  },
  'ConstructorDeclaration_returnType': {
    ElementKind.CLASS: ProbabilityRange(lower: 0.000, upper: 1.000),
  },
  'ConstructorFieldInitializer_expression': {
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.000, upper: 0.002),
    ElementKind.FIELD: ProbabilityRange(lower: 0.002, upper: 0.003),
    ElementKind.METHOD: ProbabilityRange(lower: 0.005, upper: 0.010),
    ElementKind.ENUM: ProbabilityRange(lower: 0.017, upper: 0.026),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.037, upper: 0.067),
    ElementKind.CLASS: ProbabilityRange(lower: 0.067, upper: 0.130),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.130, upper: 0.280),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.280, upper: 1.000),
  },
  'DefaultFormalParameter_defaultValue': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.001, upper: 0.002),
    ElementKind.METHOD: ProbabilityRange(lower: 0.002, upper: 0.002),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.002, upper: 0.004),
    ElementKind.FIELD: ProbabilityRange(lower: 0.004, upper: 0.014),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.014, upper: 0.031),
    ElementKind.ENUM: ProbabilityRange(lower: 0.031, upper: 0.107),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.199, upper: 0.307),
    ElementKind.CLASS: ProbabilityRange(lower: 0.719, upper: 1.000),
  },
  'DoStatement_condition': {
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.143),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.143, upper: 1.000),
  },
  'Expression': {
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.003),
    ElementKind.ENUM: ProbabilityRange(lower: 0.003, upper: 0.029),
    ElementKind.METHOD: ProbabilityRange(lower: 0.029, upper: 0.055),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.055, upper: 0.083),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.083, upper: 0.137),
    ElementKind.CLASS: ProbabilityRange(lower: 0.137, upper: 0.255),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.255, upper: 0.391),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.391, upper: 0.547),
    ElementKind.FIELD: ProbabilityRange(lower: 0.547, upper: 0.731),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.731, upper: 1.000),
  },
  'ExpressionFunctionBody_expression': {
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.ENUM: ProbabilityRange(lower: 0.004, upper: 0.005),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.027, upper: 0.034),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.045, upper: 0.061),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.061, upper: 0.092),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.092, upper: 0.130),
    ElementKind.CLASS: ProbabilityRange(lower: 0.130, upper: 0.179),
    ElementKind.METHOD: ProbabilityRange(lower: 0.179, upper: 0.231),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.231, upper: 0.421),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.421, upper: 0.691),
    ElementKind.FIELD: ProbabilityRange(lower: 0.691, upper: 1.000),
  },
  'ExpressionStatement_expression': {
    ElementKind.ENUM: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.002),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.002, upper: 0.004),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.006, upper: 0.009),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.054, upper: 0.084),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.117, upper: 0.168),
    ElementKind.CLASS: ProbabilityRange(lower: 0.218, upper: 0.284),
    ElementKind.METHOD: ProbabilityRange(lower: 0.284, upper: 0.389),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.389, upper: 0.511),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.511, upper: 0.710),
    ElementKind.FIELD: ProbabilityRange(lower: 0.710, upper: 1.000),
  },
  'ExtendsClause_superclass': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.CLASS: ProbabilityRange(lower: 0.000, upper: 1.000),
  },
  'ExtensionDeclaration_extendedType': {
    ElementKind.ENUM: ProbabilityRange(lower: 0.000, upper: 0.053),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.053, upper: 0.105),
    ElementKind.CLASS: ProbabilityRange(lower: 0.105, upper: 1.000),
  },
  'ExtensionDeclaration_member': {
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.040, upper: 0.120),
    ElementKind.CLASS: ProbabilityRange(lower: 0.120, upper: 1.000),
  },
  'FieldDeclaration_fields': {
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.001, upper: 0.002),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.002, upper: 0.003),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.003, upper: 0.004),
    ElementKind.ENUM: ProbabilityRange(lower: 0.004, upper: 0.011),
    ElementKind.CLASS: ProbabilityRange(lower: 0.119, upper: 0.491),
  },
  'ForEachPartsWithDeclaration_iterable': {
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.001, upper: 0.003),
    ElementKind.ENUM: ProbabilityRange(lower: 0.003, upper: 0.005),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.005, upper: 0.009),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.009, upper: 0.016),
    ElementKind.CLASS: ProbabilityRange(lower: 0.016, upper: 0.023),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.031, upper: 0.072),
    ElementKind.FIELD: ProbabilityRange(lower: 0.072, upper: 0.283),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.283, upper: 0.602),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.602, upper: 1.000),
  },
  'ForEachPartsWithDeclaration_loopVariable': {
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.001, upper: 0.003),
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.003, upper: 0.004),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.004, upper: 0.006),
    ElementKind.ENUM: ProbabilityRange(lower: 0.006, upper: 0.010),
    ElementKind.CLASS: ProbabilityRange(lower: 0.010, upper: 0.298),
  },
  'ForElement_body': {
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.038, upper: 0.083),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.083, upper: 0.136),
    ElementKind.METHOD: ProbabilityRange(lower: 0.136, upper: 0.220),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.220, upper: 0.303),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.303, upper: 1.000),
  },
  'ForElement_forLoopParts': {
    ElementKind.ENUM: ProbabilityRange(lower: 0.000, upper: 0.007),
    ElementKind.CLASS: ProbabilityRange(lower: 0.630, upper: 1.000),
  },
  'ForParts_condition': {
    ElementKind.FIELD: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.004, upper: 0.023),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.023, upper: 1.000),
  },
  'ForParts_updater': {
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.000, upper: 0.020),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.020, upper: 1.000),
  },
  'ForStatement_body': {
    ElementKind.METHOD: ProbabilityRange(lower: 0.065, upper: 0.194),
    ElementKind.FIELD: ProbabilityRange(lower: 0.194, upper: 0.387),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.387, upper: 1.000),
  },
  'ForStatement_forLoopParts': {
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.001, upper: 0.001),
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.001, upper: 0.002),
    ElementKind.ENUM: ProbabilityRange(lower: 0.002, upper: 0.004),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.004, upper: 0.005),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.005, upper: 0.015),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.015, upper: 0.025),
    ElementKind.CLASS: ProbabilityRange(lower: 0.561, upper: 1.000),
  },
  'FormalParameterList_parameter': {
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.001, upper: 0.003),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.003, upper: 0.005),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.005, upper: 0.013),
    ElementKind.ENUM: ProbabilityRange(lower: 0.013, upper: 0.024),
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.038, upper: 0.054),
    ElementKind.CLASS: ProbabilityRange(lower: 0.360, upper: 1.000),
  },
  'FunctionDeclaration_returnType': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.000, upper: 0.002),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.002, upper: 0.006),
    ElementKind.ENUM: ProbabilityRange(lower: 0.006, upper: 0.017),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.017, upper: 0.070),
    ElementKind.CLASS: ProbabilityRange(lower: 0.354, upper: 1.000),
  },
  'GenericTypeAlias_type': {
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.000, upper: 0.020),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.020, upper: 0.040),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.040, upper: 0.090),
    ElementKind.CLASS: ProbabilityRange(lower: 0.140, upper: 0.480),
  },
  'HideCombinator_hiddenName': {
    ElementKind.ENUM: ProbabilityRange(lower: 0.000, upper: 0.059),
    ElementKind.CLASS: ProbabilityRange(lower: 0.059, upper: 1.000),
  },
  'IfElement_condition': {
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.000, upper: 0.005),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.011, upper: 0.016),
    ElementKind.CLASS: ProbabilityRange(lower: 0.016, upper: 0.035),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.035, upper: 0.223),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.223, upper: 0.569),
    ElementKind.FIELD: ProbabilityRange(lower: 0.569, upper: 1.000),
  },
  'IfElement_elseElement': {
    ElementKind.METHOD: ProbabilityRange(lower: 0.043, upper: 0.087),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.261, upper: 1.000),
  },
  'IfElement_thenElement': {
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.000, upper: 0.003),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.003, upper: 0.011),
    ElementKind.CLASS: ProbabilityRange(lower: 0.022, upper: 0.033),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.033, upper: 0.047),
    ElementKind.FIELD: ProbabilityRange(lower: 0.063, upper: 0.082),
    ElementKind.METHOD: ProbabilityRange(lower: 0.082, upper: 0.115),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.115, upper: 1.000),
  },
  'IfStatement_condition': {
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.ENUM: ProbabilityRange(lower: 0.001, upper: 0.001),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.002, upper: 0.002),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.002, upper: 0.013),
    ElementKind.METHOD: ProbabilityRange(lower: 0.013, upper: 0.023),
    ElementKind.CLASS: ProbabilityRange(lower: 0.023, upper: 0.041),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.084, upper: 0.107),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.107, upper: 0.347),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.347, upper: 0.672),
    ElementKind.FIELD: ProbabilityRange(lower: 0.672, upper: 1.000),
  },
  'IfStatement_elseStatement': {
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.004, upper: 0.007),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.007, upper: 0.009),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.009, upper: 0.012),
    ElementKind.CLASS: ProbabilityRange(lower: 0.012, upper: 0.021),
    ElementKind.FIELD: ProbabilityRange(lower: 0.021, upper: 0.045),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.045, upper: 0.069),
    ElementKind.METHOD: ProbabilityRange(lower: 0.069, upper: 0.095),
  },
  'IfStatement_thenStatement': {
    ElementKind.MIXIN: ProbabilityRange(lower: 0.002, upper: 0.003),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.013, upper: 0.019),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.019, upper: 0.025),
    ElementKind.CLASS: ProbabilityRange(lower: 0.058, upper: 0.069),
    ElementKind.METHOD: ProbabilityRange(lower: 0.069, upper: 0.134),
    ElementKind.FIELD: ProbabilityRange(lower: 0.134, upper: 0.243),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.243, upper: 0.355),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.355, upper: 0.480),
  },
  'ImplementsClause_interface': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.003),
    ElementKind.CLASS: ProbabilityRange(lower: 0.003, upper: 1.000),
  },
  'IndexExpression_index': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.002, upper: 0.003),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.003, upper: 0.004),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.004, upper: 0.006),
    ElementKind.METHOD: ProbabilityRange(lower: 0.006, upper: 0.008),
    ElementKind.ENUM: ProbabilityRange(lower: 0.008, upper: 0.015),
    ElementKind.CLASS: ProbabilityRange(lower: 0.015, upper: 0.029),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.029, upper: 0.046),
    ElementKind.FIELD: ProbabilityRange(lower: 0.046, upper: 0.307),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.307, upper: 0.605),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.605, upper: 1.000),
  },
  'InstanceCreationExpression_constructorName': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.006),
    ElementKind.CLASS: ProbabilityRange(lower: 0.006, upper: 1.000),
  },
  'InterpolationExpression_expression': {
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.001, upper: 0.001),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.001, upper: 0.002),
    ElementKind.ENUM: ProbabilityRange(lower: 0.002, upper: 0.002),
    ElementKind.METHOD: ProbabilityRange(lower: 0.002, upper: 0.010),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.032, upper: 0.062),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.062, upper: 0.121),
    ElementKind.CLASS: ProbabilityRange(lower: 0.121, upper: 0.247),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.247, upper: 0.440),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.440, upper: 0.689),
    ElementKind.FIELD: ProbabilityRange(lower: 0.689, upper: 1.000),
  },
  'IsExpression_type': {
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.001, upper: 0.003),
    ElementKind.ENUM: ProbabilityRange(lower: 0.003, upper: 0.006),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.006, upper: 0.009),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.009, upper: 0.013),
    ElementKind.CLASS: ProbabilityRange(lower: 0.013, upper: 1.000),
  },
  'ListLiteral_element': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.004, upper: 0.008),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.008, upper: 0.011),
    ElementKind.ENUM: ProbabilityRange(lower: 0.017, upper: 0.023),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.023, upper: 0.033),
    ElementKind.FIELD: ProbabilityRange(lower: 0.033, upper: 0.047),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.047, upper: 0.063),
    ElementKind.METHOD: ProbabilityRange(lower: 0.082, upper: 0.107),
    ElementKind.CLASS: ProbabilityRange(lower: 0.107, upper: 0.147),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.147, upper: 1.000),
  },
  'MapLiteralEntry_value': {
    ElementKind.PREFIX: ProbabilityRange(lower: 0.005, upper: 0.008),
    ElementKind.METHOD: ProbabilityRange(lower: 0.008, upper: 0.011),
    ElementKind.ENUM: ProbabilityRange(lower: 0.019, upper: 0.028),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.038, upper: 0.049),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.049, upper: 0.073),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.073, upper: 0.099),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.099, upper: 0.128),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.128, upper: 0.234),
    ElementKind.FIELD: ProbabilityRange(lower: 0.234, upper: 0.393),
    ElementKind.CLASS: ProbabilityRange(lower: 0.393, upper: 1.000),
  },
  'MethodDeclaration_returnType': {
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.000, upper: 0.002),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.002, upper: 0.004),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.004, upper: 0.006),
    ElementKind.ENUM: ProbabilityRange(lower: 0.006, upper: 0.010),
    ElementKind.CLASS: ProbabilityRange(lower: 0.179, upper: 1.000),
  },
  'MixinDeclaration_member': {
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.002),
    ElementKind.ENUM: ProbabilityRange(lower: 0.002, upper: 0.007),
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.007, upper: 0.014),
    ElementKind.CLASS: ProbabilityRange(lower: 0.128, upper: 1.000),
  },
  'OnClause_superclassConstraint': {
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.392),
    ElementKind.CLASS: ProbabilityRange(lower: 0.392, upper: 1.000),
  },
  'ParenthesizedExpression_expression': {
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.ENUM: ProbabilityRange(lower: 0.001, upper: 0.002),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.002, upper: 0.004),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.004, upper: 0.008),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.008, upper: 0.013),
    ElementKind.CLASS: ProbabilityRange(lower: 0.051, upper: 0.107),
    ElementKind.METHOD: ProbabilityRange(lower: 0.107, upper: 0.177),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.177, upper: 0.267),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.267, upper: 0.491),
    ElementKind.FIELD: ProbabilityRange(lower: 0.491, upper: 0.737),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.737, upper: 1.000),
  },
  'PrefixExpression_!_operand': {
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.015, upper: 0.028),
    ElementKind.METHOD: ProbabilityRange(lower: 0.028, upper: 0.057),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.057, upper: 0.093),
    ElementKind.CLASS: ProbabilityRange(lower: 0.093, upper: 0.144),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.144, upper: 0.338),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.338, upper: 0.603),
    ElementKind.FIELD: ProbabilityRange(lower: 0.603, upper: 1.000),
  },
  'PrefixExpression_++_operand': {
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.018),
    ElementKind.FIELD: ProbabilityRange(lower: 0.035, upper: 0.351),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.351, upper: 1.000),
  },
  'PrefixExpression_--_operand': {
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.063),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.063, upper: 0.313),
    ElementKind.FIELD: ProbabilityRange(lower: 0.313, upper: 1.000),
  },
  'PrefixExpression_-_operand': {
    ElementKind.METHOD: ProbabilityRange(lower: 0.000, upper: 0.006),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.006, upper: 0.022),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.022, upper: 0.061),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.061, upper: 0.166),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.166, upper: 0.282),
    ElementKind.CLASS: ProbabilityRange(lower: 0.282, upper: 0.431),
    ElementKind.FIELD: ProbabilityRange(lower: 0.431, upper: 0.591),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.591, upper: 1.000),
  },
  'PrefixExpression_~_operand': {
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.000, upper: 1.000),
  },
  'PropertyAccess_propertyName': {
    ElementKind.METHOD: ProbabilityRange(lower: 0.000, upper: 0.002),
    ElementKind.FIELD: ProbabilityRange(lower: 0.002, upper: 1.000),
  },
  'ReturnStatement_expression': {
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.003, upper: 0.008),
    ElementKind.ENUM: ProbabilityRange(lower: 0.020, upper: 0.029),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.029, upper: 0.038),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.070, upper: 0.090),
    ElementKind.METHOD: ProbabilityRange(lower: 0.142, upper: 0.171),
    ElementKind.FIELD: ProbabilityRange(lower: 0.171, upper: 0.229),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.229, upper: 0.292),
    ElementKind.CLASS: ProbabilityRange(lower: 0.292, upper: 0.365),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.365, upper: 0.481),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.481, upper: 1.000),
  },
  'SetOrMapLiteral_element': {
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.000, upper: 0.002),
    ElementKind.METHOD: ProbabilityRange(lower: 0.002, upper: 0.005),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.005, upper: 0.009),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.015, upper: 0.022),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.040, upper: 0.051),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.051, upper: 0.107),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.107, upper: 0.231),
    ElementKind.ENUM: ProbabilityRange(lower: 0.231, upper: 0.423),
    ElementKind.FIELD: ProbabilityRange(lower: 0.423, upper: 0.653),
    ElementKind.CLASS: ProbabilityRange(lower: 0.653, upper: 1.000),
  },
  'ShowCombinator_shownName': {
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.000, upper: 0.005),
    ElementKind.ENUM: ProbabilityRange(lower: 0.005, upper: 0.032),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.032, upper: 0.216),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.216, upper: 0.568),
    ElementKind.CLASS: ProbabilityRange(lower: 0.568, upper: 1.000),
  },
  'SpreadElement_expression': {
    ElementKind.ENUM: ProbabilityRange(lower: 0.000, upper: 0.005),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.022, upper: 0.044),
    ElementKind.CLASS: ProbabilityRange(lower: 0.044, upper: 0.087),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.087, upper: 0.186),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.186, upper: 0.295),
    ElementKind.METHOD: ProbabilityRange(lower: 0.295, upper: 0.426),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.426, upper: 0.574),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.574, upper: 0.727),
    ElementKind.FIELD: ProbabilityRange(lower: 0.727, upper: 1.000),
  },
  'Statement': {
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.ENUM: ProbabilityRange(lower: 0.001, upper: 0.002),
    ElementKind.MIXIN: ProbabilityRange(lower: 0.002, upper: 0.003),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.003, upper: 0.006),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.006, upper: 0.037),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.037, upper: 0.088),
    ElementKind.METHOD: ProbabilityRange(lower: 0.088, upper: 0.195),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.195, upper: 0.319),
    ElementKind.CLASS: ProbabilityRange(lower: 0.319, upper: 0.502),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.502, upper: 0.705),
    ElementKind.FIELD: ProbabilityRange(lower: 0.705, upper: 1.000),
  },
  'SwitchCase_expression': {
    ElementKind.FIELD: ProbabilityRange(lower: 0.009, upper: 0.016),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.016, upper: 0.049),
    ElementKind.CLASS: ProbabilityRange(lower: 0.049, upper: 0.336),
    ElementKind.ENUM: ProbabilityRange(lower: 0.336, upper: 1.000),
  },
  'SwitchMember_statement': {
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.013, upper: 0.017),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.027, upper: 0.033),
    ElementKind.CLASS: ProbabilityRange(lower: 0.045, upper: 0.056),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.056, upper: 0.069),
    ElementKind.METHOD: ProbabilityRange(lower: 0.069, upper: 0.085),
    ElementKind.FIELD: ProbabilityRange(lower: 0.109, upper: 0.138),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.138, upper: 0.380),
  },
  'SwitchStatement_expression': {
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.001),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.001, upper: 0.003),
    ElementKind.METHOD: ProbabilityRange(lower: 0.006, upper: 0.010),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.016, upper: 0.023),
    ElementKind.CLASS: ProbabilityRange(lower: 0.023, upper: 0.039),
    ElementKind.FIELD: ProbabilityRange(lower: 0.039, upper: 0.211),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.211, upper: 0.517),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.517, upper: 1.000),
  },
  'ThrowExpression_expression': {
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.001, upper: 0.004),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.004, upper: 0.010),
    ElementKind.CLASS: ProbabilityRange(lower: 0.010, upper: 0.022),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.022, upper: 1.000),
  },
  'TypeArgumentList_argument': {
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.000, upper: 0.003),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.003, upper: 0.010),
    ElementKind.ENUM: ProbabilityRange(lower: 0.010, upper: 0.018),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.018, upper: 0.032),
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.053, upper: 0.164),
    ElementKind.CLASS: ProbabilityRange(lower: 0.164, upper: 1.000),
  },
  'TypeParameter_bound': {
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.016),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.016, upper: 0.039),
    ElementKind.CLASS: ProbabilityRange(lower: 0.039, upper: 1.000),
  },
  'VariableDeclarationList_type': {
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.002, upper: 0.003),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.003, upper: 0.007),
    ElementKind.UNKNOWN: ProbabilityRange(lower: 0.007, upper: 0.015),
    ElementKind.FUNCTION_TYPE_ALIAS:
        ProbabilityRange(lower: 0.015, upper: 0.031),
    ElementKind.ENUM: ProbabilityRange(lower: 0.031, upper: 0.047),
    ElementKind.CLASS: ProbabilityRange(lower: 0.047, upper: 1.000),
  },
  'VariableDeclaration_initializer': {
    ElementKind.MIXIN: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.TYPE_PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.000),
    ElementKind.PREFIX: ProbabilityRange(lower: 0.004, upper: 0.010),
    ElementKind.ENUM: ProbabilityRange(lower: 0.010, upper: 0.016),
    ElementKind.METHOD: ProbabilityRange(lower: 0.023, upper: 0.041),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.041, upper: 0.069),
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.128, upper: 0.167),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.167, upper: 0.261),
    ElementKind.FIELD: ProbabilityRange(lower: 0.261, upper: 0.357),
    ElementKind.CLASS: ProbabilityRange(lower: 0.459, upper: 0.565),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.565, upper: 0.689),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.689, upper: 1.000),
  },
  'WhileStatement_body': {
    ElementKind.METHOD: ProbabilityRange(lower: 0.000, upper: 0.200),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.200, upper: 1.000),
  },
  'WhileStatement_condition': {
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.000, upper: 0.008),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.008, upper: 0.023),
    ElementKind.FIELD: ProbabilityRange(lower: 0.023, upper: 0.050),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.085, upper: 1.000),
  },
  'WithClause_mixinType': {
    ElementKind.CLASS: ProbabilityRange(lower: 0.000, upper: 0.282),
    ElementKind.MIXIN: ProbabilityRange(lower: 0.282, upper: 1.000),
  },
  'YieldStatement_expression': {
    ElementKind.FUNCTION: ProbabilityRange(lower: 0.000, upper: 0.003),
    ElementKind.TOP_LEVEL_VARIABLE:
        ProbabilityRange(lower: 0.003, upper: 0.006),
    ElementKind.FIELD: ProbabilityRange(lower: 0.009, upper: 0.028),
    ElementKind.PARAMETER: ProbabilityRange(lower: 0.073, upper: 0.110),
    ElementKind.LOCAL_VARIABLE: ProbabilityRange(lower: 0.110, upper: 0.150),
    ElementKind.METHOD: ProbabilityRange(lower: 0.150, upper: 0.300),
    ElementKind.CONSTRUCTOR: ProbabilityRange(lower: 0.300, upper: 1.000),
  },
};

const defaultKeywordRelevance = {
  'ArgumentList_annotation_named': {
    'false': ProbabilityRange(lower: 0.159, upper: 0.517),
    'true': ProbabilityRange(lower: 0.517, upper: 1.000),
  },
  'ArgumentList_annotation_unnamed': {
    'const': ProbabilityRange(lower: 0.000, upper: 0.375),
  },
  'ArgumentList_constructorRedirect_named': {
    'null': ProbabilityRange(lower: 0.001, upper: 0.002),
    'const': ProbabilityRange(lower: 0.002, upper: 0.003),
    'true': ProbabilityRange(lower: 0.003, upper: 0.005),
    'false': ProbabilityRange(lower: 0.005, upper: 0.008),
  },
  'ArgumentList_constructorRedirect_unnamed': {
    'const': ProbabilityRange(lower: 0.005, upper: 0.011),
    'null': ProbabilityRange(lower: 0.024, upper: 0.041),
  },
  'ArgumentList_constructor_named': {
    'super': ProbabilityRange(lower: 0.000, upper: 0.000),
    'await': ProbabilityRange(lower: 0.000, upper: 0.000),
    'null': ProbabilityRange(lower: 0.004, upper: 0.007),
    'false': ProbabilityRange(lower: 0.011, upper: 0.016),
    'this': ProbabilityRange(lower: 0.016, upper: 0.023),
    'true': ProbabilityRange(lower: 0.023, upper: 0.031),
    'const': ProbabilityRange(lower: 0.031, upper: 0.042),
  },
  'ArgumentList_constructor_unnamed': {
    'await': ProbabilityRange(lower: 0.000, upper: 0.001),
    'true': ProbabilityRange(lower: 0.004, upper: 0.008),
    'false': ProbabilityRange(lower: 0.008, upper: 0.014),
    'this': ProbabilityRange(lower: 0.014, upper: 0.020),
    'null': ProbabilityRange(lower: 0.031, upper: 0.049),
    'const': ProbabilityRange(lower: 0.095, upper: 0.124),
  },
  'ArgumentList_function_named': {
    'true': ProbabilityRange(lower: 0.000, upper: 0.038),
  },
  'ArgumentList_function_unnamed': {
    'await': ProbabilityRange(lower: 0.000, upper: 0.001),
    'null': ProbabilityRange(lower: 0.001, upper: 0.003),
    'false': ProbabilityRange(lower: 0.005, upper: 0.010),
    'const': ProbabilityRange(lower: 0.016, upper: 0.024),
    'true': ProbabilityRange(lower: 0.032, upper: 0.041),
    'this': ProbabilityRange(lower: 0.103, upper: 0.171),
  },
  'ArgumentList_method_named': {
    'null': ProbabilityRange(lower: 0.000, upper: 0.001),
    'this': ProbabilityRange(lower: 0.001, upper: 0.002),
    'false': ProbabilityRange(lower: 0.055, upper: 0.079),
    'true': ProbabilityRange(lower: 0.079, upper: 0.114),
    'const': ProbabilityRange(lower: 0.564, upper: 0.760),
  },
  'ArgumentList_method_unnamed': {
    'super': ProbabilityRange(lower: 0.000, upper: 0.000),
    'await': ProbabilityRange(lower: 0.000, upper: 0.002),
    'null': ProbabilityRange(lower: 0.004, upper: 0.008),
    'false': ProbabilityRange(lower: 0.008, upper: 0.013),
    'true': ProbabilityRange(lower: 0.013, upper: 0.018),
    'const': ProbabilityRange(lower: 0.018, upper: 0.025),
    'this': ProbabilityRange(lower: 0.047, upper: 0.060),
  },
  'ArgumentList_widgetConstructor_named': {
    'super': ProbabilityRange(lower: 0.000, upper: 0.000),
    'null': ProbabilityRange(lower: 0.001, upper: 0.003),
    'this': ProbabilityRange(lower: 0.003, upper: 0.006),
    'false': ProbabilityRange(lower: 0.009, upper: 0.019),
    'true': ProbabilityRange(lower: 0.031, upper: 0.047),
    'const': ProbabilityRange(lower: 0.093, upper: 0.138),
  },
  'ArgumentList_widgetConstructor_unnamed': {
    'const': ProbabilityRange(lower: 0.000, upper: 0.000),
    'true': ProbabilityRange(lower: 0.000, upper: 0.001),
    'false': ProbabilityRange(lower: 0.001, upper: 0.002),
    'null': ProbabilityRange(lower: 0.002, upper: 0.004),
    'this': ProbabilityRange(lower: 0.012, upper: 0.018),
  },
  'AssertStatement_condition': {
    'this': ProbabilityRange(lower: 0.000, upper: 0.002),
    'await': ProbabilityRange(lower: 0.004, upper: 0.009),
    'false': ProbabilityRange(lower: 0.110, upper: 0.166),
  },
  'AssignmentExpression_rightHandSide': {
    'super': ProbabilityRange(lower: 0.000, upper: 0.000),
    'const': ProbabilityRange(lower: 0.002, upper: 0.005),
    'await': ProbabilityRange(lower: 0.043, upper: 0.066),
    'null': ProbabilityRange(lower: 0.090, upper: 0.116),
    'false': ProbabilityRange(lower: 0.116, upper: 0.153),
    'true': ProbabilityRange(lower: 0.153, upper: 0.192),
    'this': ProbabilityRange(lower: 0.192, upper: 0.233),
  },
  'AwaitExpression_expression': {
    'null': ProbabilityRange(lower: 0.000, upper: 0.000),
    'const': ProbabilityRange(lower: 0.000, upper: 0.000),
    'super': ProbabilityRange(lower: 0.000, upper: 0.000),
    'this': ProbabilityRange(lower: 0.000, upper: 0.009),
  },
  'BinaryExpression_!=_rightOperand': {
    'false': ProbabilityRange(lower: 0.001, upper: 0.002),
    'this': ProbabilityRange(lower: 0.002, upper: 0.004),
    'true': ProbabilityRange(lower: 0.004, upper: 0.007),
    'null': ProbabilityRange(lower: 0.140, upper: 1.000),
  },
  'BinaryExpression_&&_rightOperand': {
    'false': ProbabilityRange(lower: 0.000, upper: 0.000),
    'const': ProbabilityRange(lower: 0.001, upper: 0.002),
    'await': ProbabilityRange(lower: 0.002, upper: 0.003),
    'this': ProbabilityRange(lower: 0.003, upper: 0.005),
  },
  'BinaryExpression_&_rightOperand': {
    'const': ProbabilityRange(lower: 0.000, upper: 0.023),
  },
  'BinaryExpression_*_rightOperand': {
    'this': ProbabilityRange(lower: 0.001, upper: 0.004),
  },
  'BinaryExpression_+_rightOperand': {
    'const': ProbabilityRange(lower: 0.000, upper: 0.000),
    'this': ProbabilityRange(lower: 0.003, upper: 0.007),
  },
  'BinaryExpression_-_rightOperand': {
    'const': ProbabilityRange(lower: 0.000, upper: 0.001),
    'this': ProbabilityRange(lower: 0.014, upper: 0.021),
  },
  'BinaryExpression_/_rightOperand': {
    'this': ProbabilityRange(lower: 0.004, upper: 0.006),
  },
  'BinaryExpression_<=_rightOperand': {
    'this': ProbabilityRange(lower: 0.015, upper: 0.037),
  },
  'BinaryExpression_<_rightOperand': {
    'this': ProbabilityRange(lower: 0.007, upper: 0.023),
  },
  'BinaryExpression_==_rightOperand': {
    'this': ProbabilityRange(lower: 0.002, upper: 0.008),
    'false': ProbabilityRange(lower: 0.018, upper: 0.032),
    'true': ProbabilityRange(lower: 0.032, upper: 0.055),
    'null': ProbabilityRange(lower: 0.583, upper: 1.000),
  },
  'BinaryExpression_>=_rightOperand': {
    'this': ProbabilityRange(lower: 0.006, upper: 0.018),
  },
  'BinaryExpression_>_rightOperand': {
    'const': ProbabilityRange(lower: 0.029, upper: 0.043),
    'this': ProbabilityRange(lower: 0.043, upper: 0.068),
  },
  'BinaryExpression_??_rightOperand': {
    'super': ProbabilityRange(lower: 0.000, upper: 0.001),
    'await': ProbabilityRange(lower: 0.001, upper: 0.002),
    'const': ProbabilityRange(lower: 0.009, upper: 0.017),
    'null': ProbabilityRange(lower: 0.042, upper: 0.058),
    'true': ProbabilityRange(lower: 0.083, upper: 0.108),
    'false': ProbabilityRange(lower: 0.269, upper: 0.367),
    'this': ProbabilityRange(lower: 0.578, upper: 0.731),
  },
  'BinaryExpression_||_rightOperand': {
    'await': ProbabilityRange(lower: 0.000, upper: 0.004),
    'this': ProbabilityRange(lower: 0.013, upper: 0.018),
  },
  'BlockFunctionBody_start': {
    'sync': ProbabilityRange(lower: 0.000, upper: 0.003),
    'async': ProbabilityRange(lower: 0.003, upper: 1.000),
  },
  'Block_statement': {
    'do': ProbabilityRange(lower: 0.000, upper: 0.000),
    'void': ProbabilityRange(lower: 0.001, upper: 0.001),
    'break': ProbabilityRange(lower: 0.001, upper: 0.002),
    'continue': ProbabilityRange(lower: 0.003, upper: 0.004),
    'rethrow': ProbabilityRange(lower: 0.004, upper: 0.005),
    'while': ProbabilityRange(lower: 0.006, upper: 0.008),
    'yield': ProbabilityRange(lower: 0.008, upper: 0.010),
    'assert': ProbabilityRange(lower: 0.010, upper: 0.014),
    'const': ProbabilityRange(lower: 0.014, upper: 0.017),
    'switch': ProbabilityRange(lower: 0.017, upper: 0.024),
    'try': ProbabilityRange(lower: 0.024, upper: 0.032),
    'for': ProbabilityRange(lower: 0.032, upper: 0.041),
    'this': ProbabilityRange(lower: 0.041, upper: 0.050),
    'throw': ProbabilityRange(lower: 0.050, upper: 0.062),
    'super': ProbabilityRange(lower: 0.077, upper: 0.093),
    'await': ProbabilityRange(lower: 0.116, upper: 0.141),
    'var': ProbabilityRange(lower: 0.141, upper: 0.171),
    'final': ProbabilityRange(lower: 0.453, upper: 0.548),
    'if': ProbabilityRange(lower: 0.548, upper: 0.661),
    'return': ProbabilityRange(lower: 0.802, upper: 1.000),
  },
  'BooleanLiteral_start': {
    'false': ProbabilityRange(lower: 0.000, upper: 0.484),
    'true': ProbabilityRange(lower: 0.484, upper: 1.000),
  },
  'ClassDeclaration_extends': {
    'implements': ProbabilityRange(lower: 0.000, upper: 0.350),
    'with': ProbabilityRange(lower: 0.350, upper: 1.000),
  },
  'ClassDeclaration_member': {
    'operator': ProbabilityRange(lower: 0.000, upper: 0.000),
    'get': ProbabilityRange(lower: 0.004, upper: 0.005),
    'var': ProbabilityRange(lower: 0.005, upper: 0.010),
    'factory': ProbabilityRange(lower: 0.015, upper: 0.031),
    'set': ProbabilityRange(lower: 0.031, upper: 0.051),
    'const': ProbabilityRange(lower: 0.051, upper: 0.078),
    'void': ProbabilityRange(lower: 0.078, upper: 0.150),
    'static': ProbabilityRange(lower: 0.150, upper: 0.230),
    'final': ProbabilityRange(lower: 0.230, upper: 0.442),
  },
  'ClassDeclaration_name': {
    'with': ProbabilityRange(lower: 0.000, upper: 0.008),
    'implements': ProbabilityRange(lower: 0.008, upper: 0.141),
    'extends': ProbabilityRange(lower: 0.141, upper: 1.000),
  },
  'ClassDeclaration_with': {
    'implements': ProbabilityRange(lower: 0.000, upper: 1.000),
  },
  'ClassTypeAlias_superclass': {
    'with': ProbabilityRange(lower: 0.500, upper: 1.000),
  },
  'CompilationUnit_declaration': {
    'mixin': ProbabilityRange(lower: 0.003, upper: 0.005),
    'var': ProbabilityRange(lower: 0.005, upper: 0.013),
    'typedef': ProbabilityRange(lower: 0.013, upper: 0.024),
    'enum': ProbabilityRange(lower: 0.036, upper: 0.057),
    'final': ProbabilityRange(lower: 0.057, upper: 0.081),
    'void': ProbabilityRange(lower: 0.081, upper: 0.127),
    'const': ProbabilityRange(lower: 0.127, upper: 0.205),
    'class': ProbabilityRange(lower: 0.342, upper: 1.000),
  },
  'CompilationUnit_directive': {
    'library': ProbabilityRange(lower: 0.000, upper: 0.001),
    'part': ProbabilityRange(lower: 0.001, upper: 0.015),
    'export': ProbabilityRange(lower: 0.015, upper: 0.037),
    'import': ProbabilityRange(lower: 0.037, upper: 1.000),
  },
  'ConditionalExpression_elseExpression': {
    'await': ProbabilityRange(lower: 0.000, upper: 0.001),
    'throw': ProbabilityRange(lower: 0.001, upper: 0.002),
    'true': ProbabilityRange(lower: 0.005, upper: 0.009),
    'false': ProbabilityRange(lower: 0.009, upper: 0.019),
    'this': ProbabilityRange(lower: 0.019, upper: 0.030),
    'const': ProbabilityRange(lower: 0.055, upper: 0.071),
    'null': ProbabilityRange(lower: 0.289, upper: 0.412),
  },
  'ConditionalExpression_thenExpression': {
    'super': ProbabilityRange(lower: 0.000, upper: 0.000),
    'await': ProbabilityRange(lower: 0.000, upper: 0.001),
    'this': ProbabilityRange(lower: 0.004, upper: 0.009),
    'false': ProbabilityRange(lower: 0.009, upper: 0.016),
    'true': ProbabilityRange(lower: 0.016, upper: 0.024),
    'const': ProbabilityRange(lower: 0.048, upper: 0.069),
    'null': ProbabilityRange(lower: 0.367, upper: 0.513),
  },
  'ConstructorDeclaration_initializer': {
    'this': ProbabilityRange(lower: 0.000, upper: 0.033),
    'assert': ProbabilityRange(lower: 0.033, upper: 0.181),
    'super': ProbabilityRange(lower: 0.448, upper: 1.000),
  },
  'ConstructorFieldInitializer_expression': {
    'true': ProbabilityRange(lower: 0.003, upper: 0.005),
    'false': ProbabilityRange(lower: 0.010, upper: 0.017),
    'null': ProbabilityRange(lower: 0.026, upper: 0.037),
  },
  'DefaultFormalParameter_defaultValue': {
    'null': ProbabilityRange(lower: 0.000, upper: 0.001),
    'true': ProbabilityRange(lower: 0.107, upper: 0.199),
    'const': ProbabilityRange(lower: 0.307, upper: 0.452),
    'false': ProbabilityRange(lower: 0.452, upper: 0.719),
  },
  'ExpressionFunctionBody_expression': {
    'throw': ProbabilityRange(lower: 0.000, upper: 0.001),
    'super': ProbabilityRange(lower: 0.001, upper: 0.002),
    'await': ProbabilityRange(lower: 0.002, upper: 0.004),
    'const': ProbabilityRange(lower: 0.005, upper: 0.008),
    'true': ProbabilityRange(lower: 0.008, upper: 0.013),
    'this': ProbabilityRange(lower: 0.013, upper: 0.019),
    'false': ProbabilityRange(lower: 0.019, upper: 0.027),
    'null': ProbabilityRange(lower: 0.034, upper: 0.045),
  },
  'ExpressionFunctionBody_start': {
    'async': ProbabilityRange(lower: 0.000, upper: 1.000),
  },
  'ExpressionStatement_expression': {
    'const': ProbabilityRange(lower: 0.000, upper: 0.000),
    'rethrow': ProbabilityRange(lower: 0.004, upper: 0.006),
    'this': ProbabilityRange(lower: 0.009, upper: 0.029),
    'throw': ProbabilityRange(lower: 0.029, upper: 0.054),
    'super': ProbabilityRange(lower: 0.084, upper: 0.117),
    'await': ProbabilityRange(lower: 0.168, upper: 0.218),
  },
  'ExtensionDeclaration_member': {
    'void': ProbabilityRange(lower: 0.000, upper: 0.040),
  },
  'FieldDeclaration_fields': {
    'void': ProbabilityRange(lower: 0.000, upper: 0.000),
    'var': ProbabilityRange(lower: 0.011, upper: 0.024),
    'const': ProbabilityRange(lower: 0.024, upper: 0.119),
    'final': ProbabilityRange(lower: 0.491, upper: 1.000),
  },
  'ForEachPartsWithDeclaration_iterable': {
    'await': ProbabilityRange(lower: 0.000, upper: 0.001),
    'this': ProbabilityRange(lower: 0.023, upper: 0.031),
  },
  'ForEachPartsWithDeclaration_loopVariable': {
    'var': ProbabilityRange(lower: 0.298, upper: 0.628),
    'final': ProbabilityRange(lower: 0.628, upper: 1.000),
  },
  'ForElement_body': {
    'for': ProbabilityRange(lower: 0.000, upper: 0.008),
    'if': ProbabilityRange(lower: 0.008, upper: 0.038),
  },
  'ForElement_forLoopParts': {
    'var': ProbabilityRange(lower: 0.007, upper: 0.274),
    'final': ProbabilityRange(lower: 0.274, upper: 0.630),
  },
  'ForParts_condition': {
    'true': ProbabilityRange(lower: 0.001, upper: 0.004),
  },
  'ForStatement_body': {
    'for': ProbabilityRange(lower: 0.000, upper: 0.032),
    'if': ProbabilityRange(lower: 0.032, upper: 0.065),
  },
  'ForStatement_forLoopParts': {
    'final': ProbabilityRange(lower: 0.025, upper: 0.199),
    'var': ProbabilityRange(lower: 0.199, upper: 0.561),
  },
  'FormalParameterList_parameter': {
    'covariant': ProbabilityRange(lower: 0.000, upper: 0.000),
    'final': ProbabilityRange(lower: 0.000, upper: 0.001),
    'var': ProbabilityRange(lower: 0.001, upper: 0.001),
    'void': ProbabilityRange(lower: 0.024, upper: 0.038),
    'this': ProbabilityRange(lower: 0.054, upper: 0.360),
  },
  'FunctionDeclaration_returnType': {
    'void': ProbabilityRange(lower: 0.070, upper: 0.354),
  },
  'GenericTypeAlias_type': {
    'Function': ProbabilityRange(lower: 0.090, upper: 0.140),
    'void': ProbabilityRange(lower: 0.480, upper: 1.000),
  },
  'IfElement_condition': {
    'this': ProbabilityRange(lower: 0.005, upper: 0.011),
  },
  'IfElement_elseElement': {
    'for': ProbabilityRange(lower: 0.000, upper: 0.043),
    'if': ProbabilityRange(lower: 0.087, upper: 0.261),
  },
  'IfElement_thenElement': {
    'for': ProbabilityRange(lower: 0.011, upper: 0.022),
    'const': ProbabilityRange(lower: 0.047, upper: 0.063),
  },
  'IfStatement_condition': {
    'const': ProbabilityRange(lower: 0.000, upper: 0.000),
    'super': ProbabilityRange(lower: 0.000, upper: 0.000),
    'null': ProbabilityRange(lower: 0.000, upper: 0.001),
    'true': ProbabilityRange(lower: 0.001, upper: 0.002),
    'await': ProbabilityRange(lower: 0.041, upper: 0.061),
    'this': ProbabilityRange(lower: 0.061, upper: 0.084),
  },
  'IfStatement_elseStatement': {
    'await': ProbabilityRange(lower: 0.000, upper: 0.001),
    'this': ProbabilityRange(lower: 0.001, upper: 0.002),
    'throw': ProbabilityRange(lower: 0.002, upper: 0.003),
    'rethrow': ProbabilityRange(lower: 0.003, upper: 0.004),
    'return': ProbabilityRange(lower: 0.095, upper: 0.145),
    'if': ProbabilityRange(lower: 0.145, upper: 1.000),
  },
  'IfStatement_thenStatement': {
    'super': ProbabilityRange(lower: 0.000, upper: 0.000),
    'rethrow': ProbabilityRange(lower: 0.000, upper: 0.001),
    'for': ProbabilityRange(lower: 0.001, upper: 0.001),
    'while': ProbabilityRange(lower: 0.001, upper: 0.002),
    'if': ProbabilityRange(lower: 0.003, upper: 0.006),
    'break': ProbabilityRange(lower: 0.006, upper: 0.009),
    'this': ProbabilityRange(lower: 0.009, upper: 0.013),
    'await': ProbabilityRange(lower: 0.025, upper: 0.031),
    'continue': ProbabilityRange(lower: 0.031, upper: 0.038),
    'yield': ProbabilityRange(lower: 0.038, upper: 0.048),
    'throw': ProbabilityRange(lower: 0.048, upper: 0.058),
    'return': ProbabilityRange(lower: 0.480, upper: 1.000),
  },
  'ImportDirective_combinator': {
    'hide': ProbabilityRange(lower: 0.000, upper: 0.106),
    'show': ProbabilityRange(lower: 0.106, upper: 1.000),
  },
  'ImportDirective_deferred': {
    'as': ProbabilityRange(lower: 0.000, upper: 1.000),
  },
  'ImportDirective_prefix': {
    'if': ProbabilityRange(lower: 0.000, upper: 0.059),
    'show': ProbabilityRange(lower: 0.059, upper: 1.000),
  },
  'ImportDirective_uri': {
    'deferred': ProbabilityRange(lower: 0.000, upper: 0.005),
    'if': ProbabilityRange(lower: 0.005, upper: 0.017),
    'hide': ProbabilityRange(lower: 0.017, upper: 0.036),
    'show': ProbabilityRange(lower: 0.036, upper: 0.175),
    'as': ProbabilityRange(lower: 0.175, upper: 1.000),
  },
  'IndexExpression_index': {
    'await': ProbabilityRange(lower: 0.000, upper: 0.001),
    'this': ProbabilityRange(lower: 0.001, upper: 0.002),
  },
  'InterpolationExpression_expression': {
    'false': ProbabilityRange(lower: 0.000, upper: 0.000),
    'await': ProbabilityRange(lower: 0.000, upper: 0.000),
    'this': ProbabilityRange(lower: 0.010, upper: 0.032),
  },
  'ListLiteral_element': {
    'super': ProbabilityRange(lower: 0.000, upper: 0.000),
    'null': ProbabilityRange(lower: 0.000, upper: 0.000),
    'await': ProbabilityRange(lower: 0.000, upper: 0.000),
    'this': ProbabilityRange(lower: 0.000, upper: 0.000),
    'false': ProbabilityRange(lower: 0.001, upper: 0.002),
    'true': ProbabilityRange(lower: 0.002, upper: 0.003),
    'for': ProbabilityRange(lower: 0.003, upper: 0.004),
    'if': ProbabilityRange(lower: 0.011, upper: 0.017),
    'const': ProbabilityRange(lower: 0.063, upper: 0.082),
  },
  'MapLiteralEntry_value': {
    'this': ProbabilityRange(lower: 0.000, upper: 0.002),
    'true': ProbabilityRange(lower: 0.002, upper: 0.005),
    'false': ProbabilityRange(lower: 0.011, upper: 0.015),
    'const': ProbabilityRange(lower: 0.015, upper: 0.019),
    'null': ProbabilityRange(lower: 0.028, upper: 0.038),
  },
  'MethodDeclaration_returnType': {
    'void': ProbabilityRange(lower: 0.010, upper: 0.179),
  },
  'MixinDeclaration_member': {
    'static': ProbabilityRange(lower: 0.014, upper: 0.024),
    'void': ProbabilityRange(lower: 0.024, upper: 0.040),
    'set': ProbabilityRange(lower: 0.040, upper: 0.077),
    'final': ProbabilityRange(lower: 0.077, upper: 0.128),
  },
  'MixinDeclaration_name': {
    'implements': ProbabilityRange(lower: 0.000, upper: 0.083),
    'on': ProbabilityRange(lower: 0.083, upper: 1.000),
  },
  'ParenthesizedExpression_expression': {
    'true': ProbabilityRange(lower: 0.000, upper: 0.001),
    'this': ProbabilityRange(lower: 0.013, upper: 0.023),
    'await': ProbabilityRange(lower: 0.023, upper: 0.051),
  },
  'PrefixExpression_!_operand': {
    'this': ProbabilityRange(lower: 0.000, upper: 0.004),
    'await': ProbabilityRange(lower: 0.004, upper: 0.015),
  },
  'PrefixExpression_++_operand': {
    'this': ProbabilityRange(lower: 0.018, upper: 0.035),
  },
  'ReturnStatement_expression': {
    'const': ProbabilityRange(lower: 0.000, upper: 0.003),
    'super': ProbabilityRange(lower: 0.008, upper: 0.012),
    'await': ProbabilityRange(lower: 0.012, upper: 0.020),
    'this': ProbabilityRange(lower: 0.038, upper: 0.050),
    'false': ProbabilityRange(lower: 0.050, upper: 0.070),
    'null': ProbabilityRange(lower: 0.090, upper: 0.113),
    'true': ProbabilityRange(lower: 0.113, upper: 0.142),
  },
  'SetOrMapLiteral_element': {
    'const': ProbabilityRange(lower: 0.009, upper: 0.015),
    'for': ProbabilityRange(lower: 0.022, upper: 0.031),
    'if': ProbabilityRange(lower: 0.031, upper: 0.040),
  },
  'SpreadElement_expression': {
    'this': ProbabilityRange(lower: 0.005, upper: 0.022),
  },
  'SwitchCase_expression': {
    'true': ProbabilityRange(lower: 0.000, upper: 0.005),
    'false': ProbabilityRange(lower: 0.005, upper: 0.009),
  },
  'SwitchMember_statement': {
    'rethrow': ProbabilityRange(lower: 0.000, upper: 0.000),
    'try': ProbabilityRange(lower: 0.000, upper: 0.001),
    'continue': ProbabilityRange(lower: 0.001, upper: 0.001),
    'super': ProbabilityRange(lower: 0.001, upper: 0.002),
    'var': ProbabilityRange(lower: 0.002, upper: 0.003),
    'yield': ProbabilityRange(lower: 0.003, upper: 0.005),
    'switch': ProbabilityRange(lower: 0.005, upper: 0.006),
    'assert': ProbabilityRange(lower: 0.006, upper: 0.008),
    'this': ProbabilityRange(lower: 0.008, upper: 0.011),
    'await': ProbabilityRange(lower: 0.011, upper: 0.013),
    'for': ProbabilityRange(lower: 0.017, upper: 0.022),
    'throw': ProbabilityRange(lower: 0.022, upper: 0.027),
    'final': ProbabilityRange(lower: 0.033, upper: 0.045),
    'if': ProbabilityRange(lower: 0.085, upper: 0.109),
    'return': ProbabilityRange(lower: 0.380, upper: 0.642),
    'break': ProbabilityRange(lower: 0.642, upper: 1.000),
  },
  'SwitchStatement_expression': {
    'await': ProbabilityRange(lower: 0.003, upper: 0.006),
    'this': ProbabilityRange(lower: 0.010, upper: 0.016),
  },
  'ThrowExpression_expression': {
    'const': ProbabilityRange(lower: 0.000, upper: 0.001),
  },
  'TryStatement_catch': {
    'catch': ProbabilityRange(lower: 0.000, upper: 0.238),
    'finally': ProbabilityRange(lower: 0.238, upper: 0.595),
    'on': ProbabilityRange(lower: 0.595, upper: 1.000),
  },
  'TryStatement_try': {
    'finally': ProbabilityRange(lower: 0.000, upper: 0.022),
    'on': ProbabilityRange(lower: 0.022, upper: 0.183),
    'catch': ProbabilityRange(lower: 0.183, upper: 1.000),
  },
  'TypeArgumentList_argument': {
    'void': ProbabilityRange(lower: 0.032, upper: 0.053),
  },
  'VariableDeclarationList_type': {
    'void': ProbabilityRange(lower: 0.000, upper: 0.002),
  },
  'VariableDeclaration_initializer': {
    'super': ProbabilityRange(lower: 0.000, upper: 0.000),
    'null': ProbabilityRange(lower: 0.000, upper: 0.001),
    'this': ProbabilityRange(lower: 0.001, upper: 0.004),
    'true': ProbabilityRange(lower: 0.016, upper: 0.023),
    'false': ProbabilityRange(lower: 0.069, upper: 0.098),
    'const': ProbabilityRange(lower: 0.098, upper: 0.128),
    'await': ProbabilityRange(lower: 0.357, upper: 0.459),
  },
  'WhileStatement_condition': {
    'true': ProbabilityRange(lower: 0.050, upper: 0.085),
  },
  'YieldStatement_expression': {
    'null': ProbabilityRange(lower: 0.006, upper: 0.009),
    'const': ProbabilityRange(lower: 0.028, upper: 0.049),
    'await': ProbabilityRange(lower: 0.049, upper: 0.073),
  },
};

/// A table keyed by completion location and element kind whose values are the
/// ranges of the relevance of those element kinds in those locations.
Map<String, Map<ElementKind, ProbabilityRange>> elementKindRelevance =
    defaultElementKindRelevance;

/// A table keyed by completion location and keyword whose values are the
/// ranges of the relevance of those keywords in those locations.
Map<String, Map<String, ProbabilityRange>> keywordRelevance =
    defaultKeywordRelevance;
