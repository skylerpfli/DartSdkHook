// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';
import 'package:observatory/models.dart' as M;
import 'package:observatory/src/elements/curly_block.dart';
import 'package:observatory/src/elements/field_ref.dart';
import 'package:observatory/src/elements/helpers/any_ref.dart';
import 'package:observatory/src/elements/helpers/rendering_scheduler.dart';
import 'package:observatory/src/elements/helpers/custom_element.dart';
import 'package:observatory/src/elements/helpers/uris.dart';
import 'package:observatory/utils.dart';

class InstanceRefElement extends CustomElement implements Renderable {
  late RenderingScheduler<InstanceRefElement> _r;

  Stream<RenderedEvent<InstanceRefElement>> get onRendered => _r.onRendered;

  late M.IsolateRef _isolate;
  late M.InstanceRef _instance;
  late M.ObjectRepository _objects;
  M.Instance? _loadedInstance;
  late bool _expandable;
  late bool _expanded = false;

  M.IsolateRef get isolate => _isolate;
  M.InstanceRef get instance => _instance;

  factory InstanceRefElement(
      M.IsolateRef isolate, M.InstanceRef instance, M.ObjectRepository objects,
      {RenderingQueue? queue, bool expandable = true}) {
    assert(isolate != null);
    assert(instance != null);
    assert(objects != null);
    InstanceRefElement e = new InstanceRefElement.created();
    e._r = new RenderingScheduler<InstanceRefElement>(e, queue: queue);
    e._isolate = isolate;
    e._instance = instance;
    e._objects = objects;
    e._expandable = expandable;
    return e;
  }

  InstanceRefElement.created() : super.created('instance-ref');

  @override
  void attached() {
    super.attached();
    _r.enable();
  }

  @override
  void detached() {
    super.detached();
    children = <Element>[];
    _r.disable(notify: true);
  }

  void render() {
    final content = _createLink();

    if (_expandable && _hasValue()) {
      content.addAll([
        new SpanElement()..text = ' ',
        (new CurlyBlockElement(expanded: _expanded, queue: _r.queue)
              ..content = <Element>[
                new DivElement()
                  ..classes = ['indent']
                  ..children = _createValue()
              ]
              ..onToggle.listen((e) async {
                _expanded = e.control.expanded;
                if (_expanded) {
                  e.control.disabled = true;
                  await _refresh();
                  e.control.disabled = false;
                }
              }))
            .element
      ]);
    }

    children = content;
  }

  Future _refresh() async {
    _loadedInstance = await _objects.get(_isolate, _instance.id!) as M.Instance;
    _r.dirty();
  }

  List<Element> _createShowMoreButton() {
    if (_loadedInstance!.count == null) {
      return [];
    }
    final count = _loadedInstance!.count;
    final button = new ButtonElement()..text = 'show next ${count}';
    button.onClick.listen((_) async {
      button.disabled = true;
      _loadedInstance =
          await _objects.get(_isolate, _instance.id!) as M.Instance;
      _r.dirty();
    });
    return [button];
  }

  List<Element> _createLink() {
    switch (_instance.kind) {
      case M.InstanceKind.vNull:
      case M.InstanceKind.bool:
      case M.InstanceKind.int:
      case M.InstanceKind.double:
      case M.InstanceKind.float32x4:
      case M.InstanceKind.float64x2:
      case M.InstanceKind.int32x4:
        return [
          new AnchorElement(href: Uris.inspect(_isolate, object: _instance))
            ..text = _instance.valueAsString
        ];
      case M.InstanceKind.string:
        return [
          new AnchorElement(href: Uris.inspect(_isolate, object: _instance))
            ..text = Utils.formatStringAsLiteral(
                _instance.valueAsString!, _instance.valueAsStringIsTruncated!)
        ];
      case M.InstanceKind.type:
      case M.InstanceKind.functionType:
      case M.InstanceKind.typeRef:
      case M.InstanceKind.typeParameter:
      case M.InstanceKind.recordType:
        return [
          new AnchorElement(href: Uris.inspect(_isolate, object: _instance))
            ..text = _instance.name
        ];
      case M.InstanceKind.closure:
        return [
          new AnchorElement(href: Uris.inspect(_isolate, object: _instance))
            ..children = <Element>[
              new SpanElement()
                ..classes = ['emphasize']
                ..text = 'Closure',
              new SpanElement()..text = ' (${_instance.closureFunction!.name})'
            ]
        ];
      case M.InstanceKind.regExp:
        return [
          new AnchorElement(href: Uris.inspect(_isolate, object: _instance))
            ..children = <Element>[
              new SpanElement()
                ..classes = ['emphasize']
                ..text = _instance.clazz!.name,
              new SpanElement()..text = ' (${_instance.pattern!.valueAsString})'
            ]
        ];
      case M.InstanceKind.stackTrace:
        return [
          new AnchorElement(href: Uris.inspect(_isolate, object: _instance))
            ..children = <Element>[
              new SpanElement()
                ..classes = ['emphasize']
                ..text = _instance.clazz!.name,
            ]
        ];
      case M.InstanceKind.plainInstance:
      case M.InstanceKind.receivePort:
        return [
          new AnchorElement(href: Uris.inspect(_isolate, object: _instance))
            ..classes = ['emphasize']
            ..text = _instance.clazz!.name
        ];
      case M.InstanceKind.list:
      case M.InstanceKind.map:
      case M.InstanceKind.set:
      case M.InstanceKind.uint8ClampedList:
      case M.InstanceKind.uint8List:
      case M.InstanceKind.uint16List:
      case M.InstanceKind.uint32List:
      case M.InstanceKind.uint64List:
      case M.InstanceKind.int8List:
      case M.InstanceKind.int16List:
      case M.InstanceKind.int32List:
      case M.InstanceKind.int64List:
      case M.InstanceKind.float32List:
      case M.InstanceKind.float64List:
      case M.InstanceKind.int32x4List:
      case M.InstanceKind.float32x4List:
      case M.InstanceKind.float64x2List:
        return [
          new AnchorElement(href: Uris.inspect(_isolate, object: _instance))
            ..children = <Element>[
              new SpanElement()
                ..classes = ['emphasize']
                ..text = _instance.clazz!.name,
              new SpanElement()..text = ' (${_instance.length})'
            ]
        ];
      case M.InstanceKind.mirrorReference:
      case M.InstanceKind.weakProperty:
      case M.InstanceKind.finalizer:
      case M.InstanceKind.weakReference:
      case M.InstanceKind.record:
        return [
          new AnchorElement(href: Uris.inspect(_isolate, object: _instance))
            ..classes = ['emphasize']
            ..text = _instance.clazz!.name
        ];
      default:
        throw new Exception('Unknown InstanceKind: ${_instance.kind}');
    }
  }

  bool _hasValue() {
    switch (_instance.kind) {
      case M.InstanceKind.closure:
      case M.InstanceKind.plainInstance:
      case M.InstanceKind.mirrorReference:
      case M.InstanceKind.stackTrace:
      case M.InstanceKind.weakReference:
      case M.InstanceKind.weakProperty:
      case M.InstanceKind.recordType:
        return true;
      case M.InstanceKind.list:
      case M.InstanceKind.map:
      case M.InstanceKind.set:
      case M.InstanceKind.uint8ClampedList:
      case M.InstanceKind.uint8List:
      case M.InstanceKind.uint16List:
      case M.InstanceKind.uint32List:
      case M.InstanceKind.uint64List:
      case M.InstanceKind.int8List:
      case M.InstanceKind.int16List:
      case M.InstanceKind.int32List:
      case M.InstanceKind.int64List:
      case M.InstanceKind.float32List:
      case M.InstanceKind.float64List:
      case M.InstanceKind.int32x4List:
      case M.InstanceKind.float32x4List:
      case M.InstanceKind.float64x2List:
        return _instance.length! > 0;
      default:
        return false;
    }
  }

  List<Element> _createValue() {
    if (_loadedInstance == null) {
      return [new SpanElement()..text = 'Loading...'];
    }
    switch (_instance.kind) {
      case M.InstanceKind.closure:
        {
          var members = <Element>[];
          if (_loadedInstance!.closureFunction != null) {
            members.add(new DivElement()
              ..children = <Element>[
                new SpanElement()..text = 'function = ',
                anyRef(_isolate, _loadedInstance!.closureFunction, _objects,
                    queue: _r.queue)
              ]);
          }
          if (_loadedInstance!.closureContext != null) {
            members.add(new DivElement()
              ..children = <Element>[
                new SpanElement()..text = 'context = ',
                anyRef(_isolate, _loadedInstance!.closureContext, _objects,
                    queue: _r.queue)
              ]);
          }
          return members;
        }
      case M.InstanceKind.plainInstance:
        return _loadedInstance!.fields!
            .map<Element>((f) => new DivElement()
              ..children = <Element>[
                new FieldRefElement(_isolate, f.decl!, _objects,
                        queue: _r.queue)
                    .element,
                new SpanElement()..text = ' = ',
                anyRef(_isolate, f.value, _objects, queue: _r.queue)
              ])
            .toList();
      case M.InstanceKind.list:
        var index = 0;
        return _loadedInstance!.elements!
            .map<Element>((element) => new DivElement()
              ..children = <Element>[
                new SpanElement()..text = '[ ${index++} ] : ',
                anyRef(_isolate, element, _objects, queue: _r.queue)
              ])
            .toList()
          ..addAll(_createShowMoreButton());
      case M.InstanceKind.map:
        return _loadedInstance!.associations!
            .map<Element>((association) => new DivElement()
              ..children = <Element>[
                new SpanElement()..text = '[ ',
                anyRef(_isolate, association.key, _objects, queue: _r.queue),
                new SpanElement()..text = ' ] : ',
                anyRef(_isolate, association.value, _objects, queue: _r.queue)
              ])
            .toList()
          ..addAll(_createShowMoreButton());
      case M.InstanceKind.set:
        return _loadedInstance!.elements!
            .map<Element>((element) => new DivElement()
              ..children = <Element>[
                anyRef(_isolate, element, _objects, queue: _r.queue)
              ])
            .toList()
          ..addAll(_createShowMoreButton());
      case M.InstanceKind.uint8ClampedList:
      case M.InstanceKind.uint8List:
      case M.InstanceKind.uint16List:
      case M.InstanceKind.uint32List:
      case M.InstanceKind.uint64List:
      case M.InstanceKind.int8List:
      case M.InstanceKind.int16List:
      case M.InstanceKind.int32List:
      case M.InstanceKind.int64List:
      case M.InstanceKind.float32List:
      case M.InstanceKind.float64List:
      case M.InstanceKind.int32x4List:
      case M.InstanceKind.float32x4List:
      case M.InstanceKind.float64x2List:
        var index = 0;
        return _loadedInstance!.typedElements!
            .map<Element>((e) => new DivElement()..text = '[ ${index++} ] : $e')
            .toList()
          ..addAll(_createShowMoreButton());
      case M.InstanceKind.mirrorReference:
        return [
          new SpanElement()..text = '<referent> : ',
          anyRef(_isolate, _loadedInstance!.referent, _objects, queue: _r.queue)
        ];
      case M.InstanceKind.stackTrace:
        return [
          new DivElement()
            ..classes = ['stackTraceBox']
            ..text = _instance.valueAsString
        ];
      case M.InstanceKind.weakReference:
        return [
          new SpanElement()..text = '<target> : ',
          anyRef(_isolate, _loadedInstance!.target, _objects, queue: _r.queue)
        ];
      case M.InstanceKind.weakProperty:
        return [
          new SpanElement()..text = '<key> : ',
          anyRef(_isolate, _loadedInstance!.key!, _objects, queue: _r.queue),
          new BRElement(),
          new SpanElement()..text = '<value> : ',
          anyRef(_isolate, _loadedInstance!.value!, _objects, queue: _r.queue),
        ];
      case M.InstanceKind.recordType:
        final fields = _loadedInstance!.fields!.toList();
        return [
          for (int i = 0; i < fields.length; ++i) ...[
            new SpanElement()..text = '${fields[i].name} = ',
            new InstanceRefElement(
                    _isolate, fields[i].value!.asValue!, _objects,
                    queue: _r.queue)
                .element,
            if (i + 1 != fields.length) new BRElement(),
          ]
        ];
      default:
        return [];
    }
  }
}
