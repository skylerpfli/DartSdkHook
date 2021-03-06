// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'flutter_outline_computer_test.dart' as outline_computer;
import 'flutter_outline_notification_test.dart' as outline_notification;

void main() {
  defineReflectiveSuite(() {
    outline_computer.main();
    outline_notification.main();
  });
}
