// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.10

import 'package:pub/src/exit_codes.dart' as exit_codes;
import 'package:test/test.dart';

import '../descriptor.dart' as d;
import '../test_pub.dart';

void main() {
  test('force does not publish if the package is private', () async {
    var pkg = packageMap('test_pkg', '1.0.0');
    pkg['publish_to'] = 'none';
    await d.dir(appPath, [d.pubspec(pkg)]).create();

    await runPub(
        args: ['lish', '--force'],
        error: startsWith('A private package cannot be published.'),
        exitCode: exit_codes.DATA);
  });
}
