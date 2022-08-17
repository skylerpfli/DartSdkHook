Want to contribute? Great! First, read this page (including the small print at
the end).

### Before you contribute
Before we can use your code, you must sign the
[Google Individual Contributor License Agreement](https://cla.developers.google.com/about/google-individual)
(CLA), which you can do online. The CLA is necessary mainly because you own the
copyright to your changes, even after your contribution becomes part of our
codebase, so we need your permission to use and distribute your code. We also
need to be sure of various other things—for instance that you'll tell us if you
know that your code infringes on other people's patents. You don't have to sign
the CLA until after you've submitted your code for review and a member has
approved it, but you must do it before we can put your code into our codebase.

Before you start working on a larger contribution, you should get in touch with
us first through the issue tracker with your idea so that we can help out and
possibly guide you. Coordinating up front makes it much easier to avoid
frustration later on.

### Code reviews
All submissions, including submissions by project members, require review.

### Presubmit testing
* All code must pass analysis by the `dartanalyzer` (`dartanalyzer --fatal-warnings .`)
* All code must be formatted by `dartfmt` (`dartfmt -w .`)
  * _NOTE_: We currently require formatting by the `dev` channel SDK.
* All code must pass unit tests for the VM, Dart2JS, and DartDevC (`pub run build_runner test`).
  * _NOTE_: We currently use `build_runner` for compilation with DartDevC. It's
    possible to run only Dart2JS and the VM without it using `pub run test`
    directly.

### File headers
All files in the project must start with the following header.

    // Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
    // for details. All rights reserved. Use of this source code is governed by a
    // BSD-style license that can be found in the LICENSE file.

### The small print
Contributions made by corporations are covered by a different agreement than the
one above, the
[Software Grant and Corporate Contributor License Agreement](https://developers.google.com/open-source/cla/corporate).
