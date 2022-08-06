#![allow(unused)]

use std::rc::Rc;

#[derive(Debug, PartialEq)]
struct List<T> {
    head: Link<T>,
}

impl<T> From<Vec<T>> for List<T> {
    fn from(vs: Vec<T>) -> Self {
        let mut list = List::new();
        for v in vs.into_iter().rev() {
            list = list.prepend(v);
        }
        list
    }
}

impl<T> List<T> {
    pub fn new() -> Self {
        Self { head: None }
    }

    pub fn prepend(&self, v: T) -> List<T> {
        List {
            head: Some(Rc::new(Node {
                elem: v,
                next: self.head.clone(),
            })),
        }
    }

    pub fn head(&self) -> Option<&T> {
        self.head.as_ref().map(|node| &node.elem)
    }

    pub fn tail(&self) -> List<T> {
        List {
            head: self.head.as_deref().and_then(|node| node.next.clone()),
        }
    }
}

impl<T> Drop for List<T> {
    fn drop(&mut self) {
        let mut cur = self.head.take();
        while let Some(mut node) = cur {
            if let Ok(mut node) = Rc::try_unwrap(node) {
                cur = node.next.take();
            } else {
                break;
            }
        }
    }
}

type Link<T> = Option<Rc<Node<T>>>;

#[derive(Debug, PartialEq)]
struct Node<T> {
    elem: T,
    next: Link<T>,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn basic_test() {
        let list = List::from(vec![1, 2, 3]);
        assert_eq!(list.head(), Some(&1));
        assert_eq!(list.tail(), List::from(vec![2, 3]));
    }
}
