// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.57.0.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member

import 'dart:convert';
import 'dart:async';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

import 'package:meta/meta.dart';
import 'package:meta/meta.dart';
import 'dart:ffi' as ffi;

abstract class Evolution {
  Future<Life> create(
      {required Shape shape, required Boundary boundary, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kCreateConstMeta;

  Future<Pattern> decodeRle({required String rle, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kDecodeRleConstMeta;

  Future<String> encodeRle(
      {required Header header, required List<Position> cells, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kEncodeRleConstMeta;

  Future<Pattern> defaultPattern({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kDefaultPatternConstMeta;

  Future<void> evolveMethodLife({required Life that, int? step, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kEvolveMethodLifeConstMeta;

  Future<void> cleanCellsMethodLife({required Life that, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kCleanCellsMethodLifeConstMeta;

  Future<void> randMethodLife(
      {required Life that, required double distr, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kRandMethodLifeConstMeta;

  Future<List<Position>> getCellsMethodLife({required Life that, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kGetCellsMethodLifeConstMeta;

  Future<void> setCellsMethodLife(
      {required Life that, required List<Position> cells, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSetCellsMethodLifeConstMeta;

  Future<void> setBoundaryMethodLife(
      {required Life that, required Boundary boundary, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSetBoundaryMethodLifeConstMeta;

  Future<void> setShapeMethodLife(
      {required Life that, required Shape shape, bool? clean, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSetShapeMethodLifeConstMeta;

  DropFnType get dropOpaqueMutexArrayLife;
  ShareFnType get shareOpaqueMutexArrayLife;
  OpaqueTypeFinalizer get MutexArrayLifeFinalizer;
}

@sealed
class MutexArrayLife extends FrbOpaque {
  final Evolution bridge;
  MutexArrayLife.fromRaw(int ptr, int size, this.bridge)
      : super.unsafe(ptr, size);
  @override
  DropFnType get dropFn => bridge.dropOpaqueMutexArrayLife;

  @override
  ShareFnType get shareFn => bridge.shareOpaqueMutexArrayLife;

  @override
  OpaqueTypeFinalizer get staticFinalizer => bridge.MutexArrayLifeFinalizer;
}

/// 边界条件
/// Sphere 循环;
/// Mirror 镜像;
/// None 截断;
enum Boundary {
  Sphere,
  Mirror,
  None,
}

class Header {
  final String? name;
  final String? owner;
  final String? comment;
  final String? rule;
  final int x;
  final int y;

  Header({
    this.name,
    this.owner,
    this.comment,
    this.rule,
    required this.x,
    required this.y,
  });
}

class Life {
  final Evolution bridge;
  final MutexArrayLife field0;

  Life({
    required this.bridge,
    required this.field0,
  });

  Future<void> evolve({int? step, dynamic hint}) => bridge.evolveMethodLife(
        that: this,
        step: step,
      );

  Future<void> cleanCells({dynamic hint}) => bridge.cleanCellsMethodLife(
        that: this,
      );

  Future<void> rand({required double distr, dynamic hint}) =>
      bridge.randMethodLife(
        that: this,
        distr: distr,
      );

  Future<List<Position>> getCells({dynamic hint}) => bridge.getCellsMethodLife(
        that: this,
      );

  Future<void> setCells({required List<Position> cells, dynamic hint}) =>
      bridge.setCellsMethodLife(
        that: this,
        cells: cells,
      );

  Future<void> setBoundary({required Boundary boundary, dynamic hint}) =>
      bridge.setBoundaryMethodLife(
        that: this,
        boundary: boundary,
      );

  Future<void> setShape({required Shape shape, bool? clean, dynamic hint}) =>
      bridge.setShapeMethodLife(
        that: this,
        shape: shape,
        clean: clean,
      );
}

class Pattern {
  final Header header;
  final List<Position> cells;

  Pattern({
    required this.header,
    required this.cells,
  });
}

class Position {
  final int x;
  final int y;

  Position({
    required this.x,
    required this.y,
  });
}

class Shape {
  final int x;
  final int y;

  Shape({
    required this.x,
    required this.y,
  });
}

class EvolutionImpl implements Evolution {
  final EvolutionPlatform _platform;
  factory EvolutionImpl(ExternalLibrary dylib) =>
      EvolutionImpl.raw(EvolutionPlatform(dylib));

  /// Only valid on web/WASM platforms.
  factory EvolutionImpl.wasm(FutureOr<WasmModule> module) =>
      EvolutionImpl(module as ExternalLibrary);
  EvolutionImpl.raw(this._platform);
  Future<Life> create(
      {required Shape shape, required Boundary boundary, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_shape(shape);
    var arg1 = api2wire_boundary(boundary);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_create(port_, arg0, arg1),
      parseSuccessData: (d) => _wire2api_life(d),
      constMeta: kCreateConstMeta,
      argValues: [shape, boundary],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kCreateConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "create",
        argNames: ["shape", "boundary"],
      );

  Future<Pattern> decodeRle({required String rle, dynamic hint}) {
    var arg0 = _platform.api2wire_String(rle);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_decode_rle(port_, arg0),
      parseSuccessData: _wire2api_pattern,
      constMeta: kDecodeRleConstMeta,
      argValues: [rle],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kDecodeRleConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "decode_rle",
        argNames: ["rle"],
      );

  Future<String> encodeRle(
      {required Header header, required List<Position> cells, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_header(header);
    var arg1 = _platform.api2wire_list_position(cells);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_encode_rle(port_, arg0, arg1),
      parseSuccessData: _wire2api_String,
      constMeta: kEncodeRleConstMeta,
      argValues: [header, cells],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kEncodeRleConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "encode_rle",
        argNames: ["header", "cells"],
      );

  Future<Pattern> defaultPattern({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_default_pattern(port_),
      parseSuccessData: _wire2api_pattern,
      constMeta: kDefaultPatternConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kDefaultPatternConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "default_pattern",
        argNames: [],
      );

  Future<void> evolveMethodLife({required Life that, int? step, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_life(that);
    var arg1 = _platform.api2wire_opt_box_autoadd_u32(step);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_evolve__method__Life(port_, arg0, arg1),
      parseSuccessData: _wire2api_unit,
      constMeta: kEvolveMethodLifeConstMeta,
      argValues: [that, step],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kEvolveMethodLifeConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "evolve__method__Life",
        argNames: ["that", "step"],
      );

  Future<void> cleanCellsMethodLife({required Life that, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_life(that);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_clean_cells__method__Life(port_, arg0),
      parseSuccessData: _wire2api_unit,
      constMeta: kCleanCellsMethodLifeConstMeta,
      argValues: [that],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kCleanCellsMethodLifeConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "clean_cells__method__Life",
        argNames: ["that"],
      );

  Future<void> randMethodLife(
      {required Life that, required double distr, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_life(that);
    var arg1 = api2wire_f64(distr);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_rand__method__Life(port_, arg0, arg1),
      parseSuccessData: _wire2api_unit,
      constMeta: kRandMethodLifeConstMeta,
      argValues: [that, distr],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kRandMethodLifeConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "rand__method__Life",
        argNames: ["that", "distr"],
      );

  Future<List<Position>> getCellsMethodLife(
      {required Life that, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_life(that);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_get_cells__method__Life(port_, arg0),
      parseSuccessData: _wire2api_list_position,
      constMeta: kGetCellsMethodLifeConstMeta,
      argValues: [that],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kGetCellsMethodLifeConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "get_cells__method__Life",
        argNames: ["that"],
      );

  Future<void> setCellsMethodLife(
      {required Life that, required List<Position> cells, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_life(that);
    var arg1 = _platform.api2wire_list_position(cells);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_set_cells__method__Life(port_, arg0, arg1),
      parseSuccessData: _wire2api_unit,
      constMeta: kSetCellsMethodLifeConstMeta,
      argValues: [that, cells],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kSetCellsMethodLifeConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "set_cells__method__Life",
        argNames: ["that", "cells"],
      );

  Future<void> setBoundaryMethodLife(
      {required Life that, required Boundary boundary, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_life(that);
    var arg1 = api2wire_boundary(boundary);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_set_boundary__method__Life(port_, arg0, arg1),
      parseSuccessData: _wire2api_unit,
      constMeta: kSetBoundaryMethodLifeConstMeta,
      argValues: [that, boundary],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kSetBoundaryMethodLifeConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "set_boundary__method__Life",
        argNames: ["that", "boundary"],
      );

  Future<void> setShapeMethodLife(
      {required Life that, required Shape shape, bool? clean, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_life(that);
    var arg1 = _platform.api2wire_box_autoadd_shape(shape);
    var arg2 = _platform.api2wire_opt_box_autoadd_bool(clean);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_set_shape__method__Life(port_, arg0, arg1, arg2),
      parseSuccessData: _wire2api_unit,
      constMeta: kSetShapeMethodLifeConstMeta,
      argValues: [that, shape, clean],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kSetShapeMethodLifeConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "set_shape__method__Life",
        argNames: ["that", "shape", "clean"],
      );

  DropFnType get dropOpaqueMutexArrayLife =>
      _platform.inner.drop_opaque_MutexArrayLife;
  ShareFnType get shareOpaqueMutexArrayLife =>
      _platform.inner.share_opaque_MutexArrayLife;
  OpaqueTypeFinalizer get MutexArrayLifeFinalizer =>
      _platform.MutexArrayLifeFinalizer;

  void dispose() {
    _platform.dispose();
  }
// Section: wire2api

  MutexArrayLife _wire2api_MutexArrayLife(dynamic raw) {
    return MutexArrayLife.fromRaw(raw[0], raw[1], this);
  }

  String _wire2api_String(dynamic raw) {
    return raw as String;
  }

  Header _wire2api_header(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 6)
      throw Exception('unexpected arr length: expect 6 but see ${arr.length}');
    return Header(
      name: _wire2api_opt_String(arr[0]),
      owner: _wire2api_opt_String(arr[1]),
      comment: _wire2api_opt_String(arr[2]),
      rule: _wire2api_opt_String(arr[3]),
      x: _wire2api_usize(arr[4]),
      y: _wire2api_usize(arr[5]),
    );
  }

  Life _wire2api_life(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 1)
      throw Exception('unexpected arr length: expect 1 but see ${arr.length}');
    return Life(
      bridge: this,
      field0: _wire2api_MutexArrayLife(arr[0]),
    );
  }

  List<Position> _wire2api_list_position(dynamic raw) {
    return (raw as List<dynamic>).map(_wire2api_position).toList();
  }

  String? _wire2api_opt_String(dynamic raw) {
    return raw == null ? null : _wire2api_String(raw);
  }

  Pattern _wire2api_pattern(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 2)
      throw Exception('unexpected arr length: expect 2 but see ${arr.length}');
    return Pattern(
      header: _wire2api_header(arr[0]),
      cells: _wire2api_list_position(arr[1]),
    );
  }

  Position _wire2api_position(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 2)
      throw Exception('unexpected arr length: expect 2 but see ${arr.length}');
    return Position(
      x: _wire2api_usize(arr[0]),
      y: _wire2api_usize(arr[1]),
    );
  }

  int _wire2api_u8(dynamic raw) {
    return raw as int;
  }

  Uint8List _wire2api_uint_8_list(dynamic raw) {
    return raw as Uint8List;
  }

  void _wire2api_unit(dynamic raw) {
    return;
  }

  int _wire2api_usize(dynamic raw) {
    return castInt(raw);
  }
}

// Section: api2wire

@protected
bool api2wire_bool(bool raw) {
  return raw;
}

@protected
int api2wire_boundary(Boundary raw) {
  return api2wire_i32(raw.index);
}

@protected
double api2wire_f64(double raw) {
  return raw;
}

@protected
int api2wire_i32(int raw) {
  return raw;
}

@protected
int api2wire_u32(int raw) {
  return raw;
}

@protected
int api2wire_u8(int raw) {
  return raw;
}

@protected
int api2wire_usize(int raw) {
  return raw;
}
// Section: finalizer

class EvolutionPlatform extends FlutterRustBridgeBase<EvolutionWire> {
  EvolutionPlatform(ffi.DynamicLibrary dylib) : super(EvolutionWire(dylib));

// Section: api2wire

  @protected
  wire_MutexArrayLife api2wire_MutexArrayLife(MutexArrayLife raw) {
    final ptr = inner.new_MutexArrayLife();
    _api_fill_to_wire_MutexArrayLife(raw, ptr);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_String(String raw) {
    return api2wire_uint_8_list(utf8.encoder.convert(raw));
  }

  @protected
  ffi.Pointer<ffi.Bool> api2wire_box_autoadd_bool(bool raw) {
    return inner.new_box_autoadd_bool_0(api2wire_bool(raw));
  }

  @protected
  ffi.Pointer<wire_Header> api2wire_box_autoadd_header(Header raw) {
    final ptr = inner.new_box_autoadd_header_0();
    _api_fill_to_wire_header(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_Life> api2wire_box_autoadd_life(Life raw) {
    final ptr = inner.new_box_autoadd_life_0();
    _api_fill_to_wire_life(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_Shape> api2wire_box_autoadd_shape(Shape raw) {
    final ptr = inner.new_box_autoadd_shape_0();
    _api_fill_to_wire_shape(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<ffi.Uint32> api2wire_box_autoadd_u32(int raw) {
    return inner.new_box_autoadd_u32_0(api2wire_u32(raw));
  }

  @protected
  ffi.Pointer<wire_list_position> api2wire_list_position(List<Position> raw) {
    final ans = inner.new_list_position_0(raw.length);
    for (var i = 0; i < raw.length; ++i) {
      _api_fill_to_wire_position(raw[i], ans.ref.ptr[i]);
    }
    return ans;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_opt_String(String? raw) {
    return raw == null ? ffi.nullptr : api2wire_String(raw);
  }

  @protected
  ffi.Pointer<ffi.Bool> api2wire_opt_box_autoadd_bool(bool? raw) {
    return raw == null ? ffi.nullptr : api2wire_box_autoadd_bool(raw);
  }

  @protected
  ffi.Pointer<ffi.Uint32> api2wire_opt_box_autoadd_u32(int? raw) {
    return raw == null ? ffi.nullptr : api2wire_box_autoadd_u32(raw);
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list_0(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }

// Section: finalizer

  late final OpaqueTypeFinalizer _MutexArrayLifeFinalizer =
      OpaqueTypeFinalizer(inner._drop_opaque_MutexArrayLifePtr);
  OpaqueTypeFinalizer get MutexArrayLifeFinalizer => _MutexArrayLifeFinalizer;
// Section: api_fill_to_wire

  void _api_fill_to_wire_MutexArrayLife(
      MutexArrayLife apiObj, wire_MutexArrayLife wireObj) {
    wireObj.ptr = apiObj.shareOrMove();
  }

  void _api_fill_to_wire_box_autoadd_header(
      Header apiObj, ffi.Pointer<wire_Header> wireObj) {
    _api_fill_to_wire_header(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_box_autoadd_life(
      Life apiObj, ffi.Pointer<wire_Life> wireObj) {
    _api_fill_to_wire_life(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_box_autoadd_shape(
      Shape apiObj, ffi.Pointer<wire_Shape> wireObj) {
    _api_fill_to_wire_shape(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_header(Header apiObj, wire_Header wireObj) {
    wireObj.name = api2wire_opt_String(apiObj.name);
    wireObj.owner = api2wire_opt_String(apiObj.owner);
    wireObj.comment = api2wire_opt_String(apiObj.comment);
    wireObj.rule = api2wire_opt_String(apiObj.rule);
    wireObj.x = api2wire_usize(apiObj.x);
    wireObj.y = api2wire_usize(apiObj.y);
  }

  void _api_fill_to_wire_life(Life apiObj, wire_Life wireObj) {
    wireObj.field0 = api2wire_MutexArrayLife(apiObj.field0);
  }

  void _api_fill_to_wire_position(Position apiObj, wire_Position wireObj) {
    wireObj.x = api2wire_usize(apiObj.x);
    wireObj.y = api2wire_usize(apiObj.y);
  }

  void _api_fill_to_wire_shape(Shape apiObj, wire_Shape wireObj) {
    wireObj.x = api2wire_usize(apiObj.x);
    wireObj.y = api2wire_usize(apiObj.y);
  }
}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.

/// generated by flutter_rust_bridge
class EvolutionWire implements FlutterRustBridgeWireBase {
  @internal
  late final dartApi = DartApiDl(init_frb_dart_api_dl);

  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  EvolutionWire(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  EvolutionWire.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void store_dart_post_cobject(
    DartPostCObjectFnType ptr,
  ) {
    return _store_dart_post_cobject(
      ptr,
    );
  }

  late final _store_dart_post_cobjectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(DartPostCObjectFnType)>>(
          'store_dart_post_cobject');
  late final _store_dart_post_cobject = _store_dart_post_cobjectPtr
      .asFunction<void Function(DartPostCObjectFnType)>();

  Object get_dart_object(
    int ptr,
  ) {
    return _get_dart_object(
      ptr,
    );
  }

  late final _get_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Handle Function(ffi.UintPtr)>>(
          'get_dart_object');
  late final _get_dart_object =
      _get_dart_objectPtr.asFunction<Object Function(int)>();

  void drop_dart_object(
    int ptr,
  ) {
    return _drop_dart_object(
      ptr,
    );
  }

  late final _drop_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.UintPtr)>>(
          'drop_dart_object');
  late final _drop_dart_object =
      _drop_dart_objectPtr.asFunction<void Function(int)>();

  int new_dart_opaque(
    Object handle,
  ) {
    return _new_dart_opaque(
      handle,
    );
  }

  late final _new_dart_opaquePtr =
      _lookup<ffi.NativeFunction<ffi.UintPtr Function(ffi.Handle)>>(
          'new_dart_opaque');
  late final _new_dart_opaque =
      _new_dart_opaquePtr.asFunction<int Function(Object)>();

  int init_frb_dart_api_dl(
    ffi.Pointer<ffi.Void> obj,
  ) {
    return _init_frb_dart_api_dl(
      obj,
    );
  }

  late final _init_frb_dart_api_dlPtr =
      _lookup<ffi.NativeFunction<ffi.IntPtr Function(ffi.Pointer<ffi.Void>)>>(
          'init_frb_dart_api_dl');
  late final _init_frb_dart_api_dl = _init_frb_dart_api_dlPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  void wire_create(
    int port_,
    ffi.Pointer<wire_Shape> shape,
    int boundary,
  ) {
    return _wire_create(
      port_,
      shape,
      boundary,
    );
  }

  late final _wire_createPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64, ffi.Pointer<wire_Shape>, ffi.Int32)>>('wire_create');
  late final _wire_create = _wire_createPtr
      .asFunction<void Function(int, ffi.Pointer<wire_Shape>, int)>();

  void wire_decode_rle(
    int port_,
    ffi.Pointer<wire_uint_8_list> rle,
  ) {
    return _wire_decode_rle(
      port_,
      rle,
    );
  }

  late final _wire_decode_rlePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64, ffi.Pointer<wire_uint_8_list>)>>('wire_decode_rle');
  late final _wire_decode_rle = _wire_decode_rlePtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_encode_rle(
    int port_,
    ffi.Pointer<wire_Header> header,
    ffi.Pointer<wire_list_position> cells,
  ) {
    return _wire_encode_rle(
      port_,
      header,
      cells,
    );
  }

  late final _wire_encode_rlePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64, ffi.Pointer<wire_Header>,
              ffi.Pointer<wire_list_position>)>>('wire_encode_rle');
  late final _wire_encode_rle = _wire_encode_rlePtr.asFunction<
      void Function(
          int, ffi.Pointer<wire_Header>, ffi.Pointer<wire_list_position>)>();

  void wire_default_pattern(
    int port_,
  ) {
    return _wire_default_pattern(
      port_,
    );
  }

  late final _wire_default_patternPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_default_pattern');
  late final _wire_default_pattern =
      _wire_default_patternPtr.asFunction<void Function(int)>();

  void wire_evolve__method__Life(
    int port_,
    ffi.Pointer<wire_Life> that,
    ffi.Pointer<ffi.Uint32> step,
  ) {
    return _wire_evolve__method__Life(
      port_,
      that,
      step,
    );
  }

  late final _wire_evolve__method__LifePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64, ffi.Pointer<wire_Life>,
              ffi.Pointer<ffi.Uint32>)>>('wire_evolve__method__Life');
  late final _wire_evolve__method__Life =
      _wire_evolve__method__LifePtr.asFunction<
          void Function(
              int, ffi.Pointer<wire_Life>, ffi.Pointer<ffi.Uint32>)>();

  void wire_clean_cells__method__Life(
    int port_,
    ffi.Pointer<wire_Life> that,
  ) {
    return _wire_clean_cells__method__Life(
      port_,
      that,
    );
  }

  late final _wire_clean_cells__method__LifePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_Life>)>>('wire_clean_cells__method__Life');
  late final _wire_clean_cells__method__Life =
      _wire_clean_cells__method__LifePtr
          .asFunction<void Function(int, ffi.Pointer<wire_Life>)>();

  void wire_rand__method__Life(
    int port_,
    ffi.Pointer<wire_Life> that,
    double distr,
  ) {
    return _wire_rand__method__Life(
      port_,
      that,
      distr,
    );
  }

  late final _wire_rand__method__LifePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64, ffi.Pointer<wire_Life>,
              ffi.Double)>>('wire_rand__method__Life');
  late final _wire_rand__method__Life = _wire_rand__method__LifePtr
      .asFunction<void Function(int, ffi.Pointer<wire_Life>, double)>();

  void wire_get_cells__method__Life(
    int port_,
    ffi.Pointer<wire_Life> that,
  ) {
    return _wire_get_cells__method__Life(
      port_,
      that,
    );
  }

  late final _wire_get_cells__method__LifePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_Life>)>>('wire_get_cells__method__Life');
  late final _wire_get_cells__method__Life = _wire_get_cells__method__LifePtr
      .asFunction<void Function(int, ffi.Pointer<wire_Life>)>();

  void wire_set_cells__method__Life(
    int port_,
    ffi.Pointer<wire_Life> that,
    ffi.Pointer<wire_list_position> cells,
  ) {
    return _wire_set_cells__method__Life(
      port_,
      that,
      cells,
    );
  }

  late final _wire_set_cells__method__LifePtr = _lookup<
          ffi.NativeFunction<
              ffi.Void Function(ffi.Int64, ffi.Pointer<wire_Life>,
                  ffi.Pointer<wire_list_position>)>>(
      'wire_set_cells__method__Life');
  late final _wire_set_cells__method__Life =
      _wire_set_cells__method__LifePtr.asFunction<
          void Function(
              int, ffi.Pointer<wire_Life>, ffi.Pointer<wire_list_position>)>();

  void wire_set_boundary__method__Life(
    int port_,
    ffi.Pointer<wire_Life> that,
    int boundary,
  ) {
    return _wire_set_boundary__method__Life(
      port_,
      that,
      boundary,
    );
  }

  late final _wire_set_boundary__method__LifePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64, ffi.Pointer<wire_Life>,
              ffi.Int32)>>('wire_set_boundary__method__Life');
  late final _wire_set_boundary__method__Life =
      _wire_set_boundary__method__LifePtr
          .asFunction<void Function(int, ffi.Pointer<wire_Life>, int)>();

  void wire_set_shape__method__Life(
    int port_,
    ffi.Pointer<wire_Life> that,
    ffi.Pointer<wire_Shape> shape,
    ffi.Pointer<ffi.Bool> clean,
  ) {
    return _wire_set_shape__method__Life(
      port_,
      that,
      shape,
      clean,
    );
  }

  late final _wire_set_shape__method__LifePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64,
              ffi.Pointer<wire_Life>,
              ffi.Pointer<wire_Shape>,
              ffi.Pointer<ffi.Bool>)>>('wire_set_shape__method__Life');
  late final _wire_set_shape__method__Life =
      _wire_set_shape__method__LifePtr.asFunction<
          void Function(int, ffi.Pointer<wire_Life>, ffi.Pointer<wire_Shape>,
              ffi.Pointer<ffi.Bool>)>();

  wire_MutexArrayLife new_MutexArrayLife() {
    return _new_MutexArrayLife();
  }

  late final _new_MutexArrayLifePtr =
      _lookup<ffi.NativeFunction<wire_MutexArrayLife Function()>>(
          'new_MutexArrayLife');
  late final _new_MutexArrayLife =
      _new_MutexArrayLifePtr.asFunction<wire_MutexArrayLife Function()>();

  ffi.Pointer<ffi.Bool> new_box_autoadd_bool_0(
    bool value,
  ) {
    return _new_box_autoadd_bool_0(
      value,
    );
  }

  late final _new_box_autoadd_bool_0Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Bool> Function(ffi.Bool)>>(
          'new_box_autoadd_bool_0');
  late final _new_box_autoadd_bool_0 = _new_box_autoadd_bool_0Ptr
      .asFunction<ffi.Pointer<ffi.Bool> Function(bool)>();

  ffi.Pointer<wire_Header> new_box_autoadd_header_0() {
    return _new_box_autoadd_header_0();
  }

  late final _new_box_autoadd_header_0Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_Header> Function()>>(
          'new_box_autoadd_header_0');
  late final _new_box_autoadd_header_0 = _new_box_autoadd_header_0Ptr
      .asFunction<ffi.Pointer<wire_Header> Function()>();

  ffi.Pointer<wire_Life> new_box_autoadd_life_0() {
    return _new_box_autoadd_life_0();
  }

  late final _new_box_autoadd_life_0Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_Life> Function()>>(
          'new_box_autoadd_life_0');
  late final _new_box_autoadd_life_0 = _new_box_autoadd_life_0Ptr
      .asFunction<ffi.Pointer<wire_Life> Function()>();

  ffi.Pointer<wire_Shape> new_box_autoadd_shape_0() {
    return _new_box_autoadd_shape_0();
  }

  late final _new_box_autoadd_shape_0Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_Shape> Function()>>(
          'new_box_autoadd_shape_0');
  late final _new_box_autoadd_shape_0 = _new_box_autoadd_shape_0Ptr
      .asFunction<ffi.Pointer<wire_Shape> Function()>();

  ffi.Pointer<ffi.Uint32> new_box_autoadd_u32_0(
    int value,
  ) {
    return _new_box_autoadd_u32_0(
      value,
    );
  }

  late final _new_box_autoadd_u32_0Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Uint32> Function(ffi.Uint32)>>(
          'new_box_autoadd_u32_0');
  late final _new_box_autoadd_u32_0 = _new_box_autoadd_u32_0Ptr
      .asFunction<ffi.Pointer<ffi.Uint32> Function(int)>();

  ffi.Pointer<wire_list_position> new_list_position_0(
    int len,
  ) {
    return _new_list_position_0(
      len,
    );
  }

  late final _new_list_position_0Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_list_position> Function(
              ffi.Int32)>>('new_list_position_0');
  late final _new_list_position_0 = _new_list_position_0Ptr
      .asFunction<ffi.Pointer<wire_list_position> Function(int)>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list_0(
    int len,
  ) {
    return _new_uint_8_list_0(
      len,
    );
  }

  late final _new_uint_8_list_0Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_uint_8_list> Function(
              ffi.Int32)>>('new_uint_8_list_0');
  late final _new_uint_8_list_0 = _new_uint_8_list_0Ptr
      .asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  void drop_opaque_MutexArrayLife(
    ffi.Pointer<ffi.Void> ptr,
  ) {
    return _drop_opaque_MutexArrayLife(
      ptr,
    );
  }

  late final _drop_opaque_MutexArrayLifePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>(
          'drop_opaque_MutexArrayLife');
  late final _drop_opaque_MutexArrayLife = _drop_opaque_MutexArrayLifePtr
      .asFunction<void Function(ffi.Pointer<ffi.Void>)>();

  ffi.Pointer<ffi.Void> share_opaque_MutexArrayLife(
    ffi.Pointer<ffi.Void> ptr,
  ) {
    return _share_opaque_MutexArrayLife(
      ptr,
    );
  }

  late final _share_opaque_MutexArrayLifePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('share_opaque_MutexArrayLife');
  late final _share_opaque_MutexArrayLife = _share_opaque_MutexArrayLifePtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  void free_WireSyncReturn(
    WireSyncReturn ptr,
  ) {
    return _free_WireSyncReturn(
      ptr,
    );
  }

  late final _free_WireSyncReturnPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(WireSyncReturn)>>(
          'free_WireSyncReturn');
  late final _free_WireSyncReturn =
      _free_WireSyncReturnPtr.asFunction<void Function(WireSyncReturn)>();
}

class _Dart_Handle extends ffi.Opaque {}

class wire_Shape extends ffi.Struct {
  @ffi.UintPtr()
  external int x;

  @ffi.UintPtr()
  external int y;
}

class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

class wire_Header extends ffi.Struct {
  external ffi.Pointer<wire_uint_8_list> name;

  external ffi.Pointer<wire_uint_8_list> owner;

  external ffi.Pointer<wire_uint_8_list> comment;

  external ffi.Pointer<wire_uint_8_list> rule;

  @ffi.UintPtr()
  external int x;

  @ffi.UintPtr()
  external int y;
}

class wire_Position extends ffi.Struct {
  @ffi.UintPtr()
  external int x;

  @ffi.UintPtr()
  external int y;
}

class wire_list_position extends ffi.Struct {
  external ffi.Pointer<wire_Position> ptr;

  @ffi.Int32()
  external int len;
}

class wire_MutexArrayLife extends ffi.Struct {
  external ffi.Pointer<ffi.Void> ptr;
}

class wire_Life extends ffi.Struct {
  external wire_MutexArrayLife field0;
}

typedef DartPostCObjectFnType = ffi.Pointer<
    ffi.NativeFunction<ffi.Bool Function(DartPort, ffi.Pointer<ffi.Void>)>>;
typedef DartPort = ffi.Int64;
