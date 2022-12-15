pub use std::sync::Mutex;
use std::sync::MutexGuard;

use flutter_rust_bridge::RustOpaque;

pub use crate::array_life::ArrayLife;

/// 边界条件
/// Sphere 循环;
/// Mirror 镜像;
/// None 截断;
#[derive(Debug, Eq, PartialEq)]
pub enum Boundary {
    Sphere,
    Mirror,
    None,
}

// 网格形状(大小)
#[derive(Debug, Eq, PartialEq, Default)]
pub struct Shape {
    pub x: usize,
    pub y: usize,
}

// 细胞位置
#[derive(Debug, Eq, PartialEq, Default)]
pub struct Position {
    pub x: usize,
    pub y: usize,
}

pub trait LifeAPI {
    fn evolve(&mut self, step: Option<u32>);

    fn clean_cells(&mut self);

    fn get_cells(&self) -> Vec<Position>;

    fn set_cells(&mut self, cells: Vec<Position>);

    fn set_boundary(&mut self, boundary: Boundary);
}

// flutter_rust_bridge 要求 &self，使用 Mutex 修改内部结构
pub struct Life(pub RustOpaque<Mutex<ArrayLife>>);

impl Life {
    fn lock(&self) -> MutexGuard<ArrayLife> {
        self.0.lock().unwrap()
    }

    pub fn evolve(&self, step: Option<u32>) -> Vec<Position> {
        let mut life = self.lock();

        life.evolve(step);
        life.get_cells()
    }

    pub fn clean_cells(&self) {
        self.lock().clean_cells();
    }

    pub fn get_cells(&self) {
        self.lock().get_cells();
    }

    pub fn set_cells(&self, cells: Vec<Position>) {
        self.lock().set_cells(cells);
    }

    pub fn set_boundary(&self, boundary: Boundary) {
        self.lock().set_boundary(boundary);
    }
}

pub fn create(shape: Shape, boundary: Boundary) -> Life {
    let array_life = ArrayLife::new(shape, boundary);

    Life(RustOpaque::new(Mutex::new(array_life)))
}

pub fn default_cells() -> Vec<Position> {
    include!("gospers_glider_gun.txt")
}
