pub mod rle;

pub(self) use crate::bridge::Position;
use crate::bridge::Shape;

#[derive(Debug, Eq, PartialEq, Default)]
pub struct Header {
    pub name: Option<String>,
    pub owner: Option<String>,
    pub comment: Option<String>,
    pub rule: Option<String>,
    pub shape: Box<Shape>,
}

#[derive(Debug, Eq, PartialEq, Default)]
pub struct Pattern {
    pub header: Box<Header>,
    pub cells: Vec<Position>,
}
