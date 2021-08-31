// Copyright (c) 2016, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

mixin M { //LINT
  static const Z = 1; //LINT
  int get z => 0; // LINT
  void  f() //LINT
  { }
}

abstract class A //LINT
    {

  /// Zapp.
  int get zapp => 0;
  set zapp(int z) //OK
  { }

  int get zapp2 => 0; //LINT
  /// Zapp.
  set zapp2(int z) { }

  static const Z = 1; //LINT
  static int _Z = 13; //OK

  A(); //LINT
  A.named(); //LINT
  A._(); //OK
  int x; //LINT
  int _y; //OK
  int z, //LINT
      _z; //OK
  /// Doc.
  a() {
    inner() => null; //OK
  }

  // No doc.
  b(); //LINT

  c(); //LINT
}

/// Zapp.
int get zapp => 0;
set zapp(int z) //OK
{ }

int get zapp2 => 0; //LINT
/// Zapp.
set zapp2(int z) { }


main() //OK
{ }

typedef bool t(Object o); //LINT

abstract class _B {
  a(); //OK
}

enum E //LINT
{
  A, //LINT
  _B //OK
}

enum _F {
  F //OK
}

/// A D.
abstract class D extends A {
  /// Make a D.
  D();

  @override
  a() => null; //OK

  c() => null; // Un-annotated override -- OK!
}

foo() => null; //LINT

/// Bar.
bar() => null; //OK

int g; //LINT

int _h; //OK

int gg, //LINT
    _gg; //OK

/// ZZ.
class ZZ {
  /// Z.
  int get z => 0;
}

/// ZZZ.
class ZZZ extends ZZ {
  set z(int z) //OK
  { }
}

extension EE on Object { // LINT
  int get z => 0; // LINT

  /// ZZ.
  int get zz => 0;
  set zz(int z) // OK
  { }

  static int baz = 1; // LINT
}

extension _E on Object { // OK
  int get z => 0; // OK
  static int bar = 1; // OK
}

extension on Object { // OK
  int get z => 0; // OK
  static int foo = 1; // OK
}

typedef T = void Function(); // LINT
