#![allow(
    non_camel_case_types,
    unused,
    clippy::redundant_closure,
    clippy::useless_conversion,
    clippy::unit_arg,
    clippy::double_parens,
    non_snake_case,
    clippy::too_many_arguments
)]
// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.57.0.

use crate::bridge::*;
use core::panic::UnwindSafe;
use flutter_rust_bridge::*;
use std::ffi::c_void;
use std::sync::Arc;

// Section: imports

use crate::pattern::Header;
use crate::pattern::Pattern;

// Section: wire functions

fn wire_create_impl(
    port_: MessagePort,
    shape: impl Wire2Api<Shape> + UnwindSafe,
    boundary: impl Wire2Api<Boundary> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "create",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_shape = shape.wire2api();
            let api_boundary = boundary.wire2api();
            move |task_callback| Ok(create(api_shape, api_boundary))
        },
    )
}
fn wire_decode_rle_impl(port_: MessagePort, rle: impl Wire2Api<String> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "decode_rle",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_rle = rle.wire2api();
            move |task_callback| decode_rle(api_rle)
        },
    )
}
fn wire_encode_rle_impl(
    port_: MessagePort,
    header: impl Wire2Api<Header> + UnwindSafe,
    cells: impl Wire2Api<Vec<Position>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "encode_rle",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_header = header.wire2api();
            let api_cells = cells.wire2api();
            move |task_callback| Ok(encode_rle(api_header, api_cells))
        },
    )
}
fn wire_default_pattern_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "default_pattern",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Ok(default_pattern()),
    )
}
fn wire_evolve__method__Life_impl(
    port_: MessagePort,
    that: impl Wire2Api<Life> + UnwindSafe,
    step: impl Wire2Api<Option<u32>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "evolve__method__Life",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_that = that.wire2api();
            let api_step = step.wire2api();
            move |task_callback| Ok(Life::evolve(&api_that, api_step))
        },
    )
}
fn wire_clean_cells__method__Life_impl(port_: MessagePort, that: impl Wire2Api<Life> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "clean_cells__method__Life",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_that = that.wire2api();
            move |task_callback| Ok(Life::clean_cells(&api_that))
        },
    )
}
fn wire_rand__method__Life_impl(
    port_: MessagePort,
    that: impl Wire2Api<Life> + UnwindSafe,
    distr: impl Wire2Api<f64> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "rand__method__Life",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_that = that.wire2api();
            let api_distr = distr.wire2api();
            move |task_callback| Ok(Life::rand(&api_that, api_distr))
        },
    )
}
fn wire_get_cells__method__Life_impl(port_: MessagePort, that: impl Wire2Api<Life> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "get_cells__method__Life",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_that = that.wire2api();
            move |task_callback| Ok(Life::get_cells(&api_that))
        },
    )
}
fn wire_set_cells__method__Life_impl(
    port_: MessagePort,
    that: impl Wire2Api<Life> + UnwindSafe,
    cells: impl Wire2Api<Vec<Position>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "set_cells__method__Life",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_that = that.wire2api();
            let api_cells = cells.wire2api();
            move |task_callback| Ok(Life::set_cells(&api_that, api_cells))
        },
    )
}
fn wire_set_boundary__method__Life_impl(
    port_: MessagePort,
    that: impl Wire2Api<Life> + UnwindSafe,
    boundary: impl Wire2Api<Boundary> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "set_boundary__method__Life",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_that = that.wire2api();
            let api_boundary = boundary.wire2api();
            move |task_callback| Ok(Life::set_boundary(&api_that, api_boundary))
        },
    )
}
fn wire_set_shape__method__Life_impl(
    port_: MessagePort,
    that: impl Wire2Api<Life> + UnwindSafe,
    shape: impl Wire2Api<Shape> + UnwindSafe,
    clean: impl Wire2Api<Option<bool>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "set_shape__method__Life",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_that = that.wire2api();
            let api_shape = shape.wire2api();
            let api_clean = clean.wire2api();
            move |task_callback| Ok(Life::set_shape(&api_that, api_shape, api_clean))
        },
    )
}
// Section: wrapper structs

// Section: static checks

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

pub trait Wire2Api<T> {
    fn wire2api(self) -> T;
}

impl<T, S> Wire2Api<Option<T>> for *mut S
where
    *mut S: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        (!self.is_null()).then(|| self.wire2api())
    }
}

impl Wire2Api<bool> for bool {
    fn wire2api(self) -> bool {
        self
    }
}
impl Wire2Api<Boundary> for i32 {
    fn wire2api(self) -> Boundary {
        match self {
            0 => Boundary::Sphere,
            1 => Boundary::Mirror,
            2 => Boundary::None,
            _ => unreachable!("Invalid variant for Boundary: {}", self),
        }
    }
}
impl Wire2Api<bool> for *mut bool {
    fn wire2api(self) -> bool {
        unsafe { *support::box_from_leak_ptr(self) }
    }
}

impl Wire2Api<u32> for *mut u32 {
    fn wire2api(self) -> u32 {
        unsafe { *support::box_from_leak_ptr(self) }
    }
}
impl Wire2Api<f64> for f64 {
    fn wire2api(self) -> f64 {
        self
    }
}

impl Wire2Api<i32> for i32 {
    fn wire2api(self) -> i32 {
        self
    }
}

impl Wire2Api<u32> for u32 {
    fn wire2api(self) -> u32 {
        self
    }
}
impl Wire2Api<u8> for u8 {
    fn wire2api(self) -> u8 {
        self
    }
}

impl Wire2Api<usize> for usize {
    fn wire2api(self) -> usize {
        self
    }
}
// Section: impl IntoDart

impl support::IntoDart for Header {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.name.into_dart(),
            self.owner.into_dart(),
            self.comment.into_dart(),
            self.rule.into_dart(),
            self.x.into_dart(),
            self.y.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Header {}

impl support::IntoDart for Life {
    fn into_dart(self) -> support::DartAbi {
        vec![self.0.into_dart()].into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Life {}

impl support::IntoDart for Pattern {
    fn into_dart(self) -> support::DartAbi {
        vec![self.header.into_dart(), self.cells.into_dart()].into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Pattern {}

impl support::IntoDart for Position {
    fn into_dart(self) -> support::DartAbi {
        vec![self.x.into_dart(), self.y.into_dart()].into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Position {}

// Section: executor

support::lazy_static! {
    pub static ref FLUTTER_RUST_BRIDGE_HANDLER: support::DefaultHandler = Default::default();
}

#[cfg(not(target_family = "wasm"))]
#[path = "bridge_generated.io.rs"]
mod io;
#[cfg(not(target_family = "wasm"))]
pub use io::*;
