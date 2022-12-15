use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_create(port_: i64, shape: *mut wire_Shape, boundary: i32) {
    wire_create_impl(port_, shape, boundary)
}

#[no_mangle]
pub extern "C" fn wire_default_cells(port_: i64) {
    wire_default_cells_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_evolve__method__Life(port_: i64, that: *mut wire_Life, step: *mut u32) {
    wire_evolve__method__Life_impl(port_, that, step)
}

#[no_mangle]
pub extern "C" fn wire_clean_cells__method__Life(port_: i64, that: *mut wire_Life) {
    wire_clean_cells__method__Life_impl(port_, that)
}

#[no_mangle]
pub extern "C" fn wire_get_cells__method__Life(port_: i64, that: *mut wire_Life) {
    wire_get_cells__method__Life_impl(port_, that)
}

#[no_mangle]
pub extern "C" fn wire_set_cells__method__Life(
    port_: i64,
    that: *mut wire_Life,
    cells: *mut wire_list_position,
) {
    wire_set_cells__method__Life_impl(port_, that, cells)
}

#[no_mangle]
pub extern "C" fn wire_set_boundary__method__Life(port_: i64, that: *mut wire_Life, boundary: i32) {
    wire_set_boundary__method__Life_impl(port_, that, boundary)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_MutexArrayLife() -> wire_MutexArrayLife {
    wire_MutexArrayLife::new_with_null_ptr()
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_life_0() -> *mut wire_Life {
    support::new_leak_box_ptr(wire_Life::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_shape_0() -> *mut wire_Shape {
    support::new_leak_box_ptr(wire_Shape::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_u32_0(value: u32) -> *mut u32 {
    support::new_leak_box_ptr(value)
}

#[no_mangle]
pub extern "C" fn new_list_position_0(len: i32) -> *mut wire_list_position {
    let wrap = wire_list_position {
        ptr: support::new_leak_vec_ptr(<wire_Position>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

// Section: related functions

#[no_mangle]
pub extern "C" fn drop_opaque_MutexArrayLife(ptr: *const c_void) {
    unsafe {
        Arc::<Mutex<ArrayLife>>::decrement_strong_count(ptr as _);
    }
}

#[no_mangle]
pub extern "C" fn share_opaque_MutexArrayLife(ptr: *const c_void) -> *const c_void {
    unsafe {
        Arc::<Mutex<ArrayLife>>::increment_strong_count(ptr as _);
        ptr
    }
}

// Section: impl Wire2Api

impl Wire2Api<RustOpaque<Mutex<ArrayLife>>> for wire_MutexArrayLife {
    fn wire2api(self) -> RustOpaque<Mutex<ArrayLife>> {
        unsafe { support::opaque_from_dart(self.ptr as _) }
    }
}

impl Wire2Api<Life> for *mut wire_Life {
    fn wire2api(self) -> Life {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<Life>::wire2api(*wrap).into()
    }
}
impl Wire2Api<Shape> for *mut wire_Shape {
    fn wire2api(self) -> Shape {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<Shape>::wire2api(*wrap).into()
    }
}

impl Wire2Api<Life> for wire_Life {
    fn wire2api(self) -> Life {
        Life(self.field0.wire2api())
    }
}
impl Wire2Api<Vec<Position>> for *mut wire_list_position {
    fn wire2api(self) -> Vec<Position> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}

impl Wire2Api<Position> for wire_Position {
    fn wire2api(self) -> Position {
        Position {
            x: self.x.wire2api(),
            y: self.y.wire2api(),
        }
    }
}
impl Wire2Api<Shape> for wire_Shape {
    fn wire2api(self) -> Shape {
        Shape {
            x: self.x.wire2api(),
            y: self.y.wire2api(),
        }
    }
}

// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_MutexArrayLife {
    ptr: *const core::ffi::c_void,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Life {
    field0: wire_MutexArrayLife,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_list_position {
    ptr: *mut wire_Position,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Position {
    x: usize,
    y: usize,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Shape {
    x: usize,
    y: usize,
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

impl NewWithNullPtr for wire_MutexArrayLife {
    fn new_with_null_ptr() -> Self {
        Self {
            ptr: core::ptr::null(),
        }
    }
}

impl NewWithNullPtr for wire_Life {
    fn new_with_null_ptr() -> Self {
        Self {
            field0: wire_MutexArrayLife::new_with_null_ptr(),
        }
    }
}

impl NewWithNullPtr for wire_Position {
    fn new_with_null_ptr() -> Self {
        Self {
            x: Default::default(),
            y: Default::default(),
        }
    }
}

impl NewWithNullPtr for wire_Shape {
    fn new_with_null_ptr() -> Self {
        Self {
            x: Default::default(),
            y: Default::default(),
        }
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturnStruct(val: support::WireSyncReturnStruct) {
    unsafe {
        let _ = support::vec_from_leak_ptr(val.ptr, val.len);
    }
}
