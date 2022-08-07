#![allow(unused)]

use std::io::BufRead;

pub struct List<T> {
    head: Link<T>,
}

impl<T> From<Vec<T>> for List<T> {
    fn from(vs: Vec<T>) -> Self {
        let mut list = List::new();
        for v in vs.into_iter().rev() {
            list.push(v);
        }
        list
    }
}

impl<T> List<T> {
    pub fn new() -> Self {
        Self { head: None }
    }

    /// Push new element to the top of the list.
    pub fn push(&mut self, v: T) {
        let node = Node {
            elem: v,
            next: self.head.take(),
        };

        self.head = Some(Box::new(node));
    }

    pub fn pop(&mut self) -> Option<T> {
        self.head.take().map(|node| {
            self.head = node.next;
            node.elem
        })
    }

    pub fn peek(&self) -> Option<&T> {
        self.head.as_ref().map(|node| &node.elem)
    }

    pub fn peek_mut(&mut self) -> Option<&mut T> {
        self.head.as_mut().map(|node| &mut node.elem)
    }
}

impl<T> Drop for List<T> {
    fn drop(&mut self) {
        let mut cur = self.head.take();
        while let Some(mut node) = cur {
            cur = node.next.take();
        }
    }
}

pub struct Iter<'a, T> {
    next: Option<&'a Node<T>>,
}

pub struct IterMut<'a, T> {
    next: Option<&'a mut Node<T>>,
}

impl<T> List<T> {
    pub fn iter(&self) -> Iter<T> {
        Iter {
            next: self.head.as_deref(),
        }
    }

    pub fn iter_mut(&mut self) -> IterMut<T> {
        IterMut {
            next: self.head.as_deref_mut(),
        }
    }
}

impl<'a, T> Iterator for Iter<'a, T> {
    type Item = &'a T;
    fn next(&mut self) -> Option<Self::Item> {
        self.next.map(|node| {
            self.next = node.next.as_deref();
            &node.elem
        })
    }
}

impl<'a, T> Iterator for IterMut<'a, T> {
    type Item = &'a mut T;
    fn next(&mut self) -> Option<Self::Item> {
        self.next.take().map(|node| {
            self.next = node.next.as_deref_mut();
            &mut node.elem
        })
    }
}

type Link<T> = Option<Box<Node<T>>>;

struct Node<T> {
    elem: T,
    next: Link<T>,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn peek_mut() {
        let mut list = List::new();
        assert_eq!(list.peek(), None);
        list.push(1);
        list.push(3);
        let top = list.peek_mut();
        assert_eq!(top, Some(&mut 3));
        top.map(|v| {
            *v = 20;
            v
        });
        assert_eq!(list.peek(), Some(&20));
    }

    #[test]
    fn peek() {
        let mut list = List::new();
        assert_eq!(list.peek(), None);
        list.push(1);
        list.push(2);
        list.push(3);
        assert_eq!(list.peek(), Some(&3));
    }

    #[test]
    fn basics_test() {
        let mut list = List::new();
        assert_eq!(list.pop(), None);

        list.push(1);
        list.push(2);
        list.push(3);
        assert_eq!(list.pop(), Some(3));
        assert_eq!(list.pop(), Some(2));
        assert_eq!(list.pop(), Some(1));
        assert_eq!(list.pop(), None);

        // to show the dropping output
        list.push(1);
        list.push(2);
        list.push(3);
    }

    #[test]
    fn iter() {
        let list = vec![1, 2, 3];
        let values: Vec<i32> = list.to_vec();
        assert_eq!(values, vec![1, 2, 3]);
    }

    #[test]
    fn iter_mut() {
        let mut list = vec![1, 2, 3];
        for v in list.iter_mut() {
            *v *= 10;
        }
        let values: Vec<i32> = list.to_vec();
        assert_eq!(values, vec![10, 20, 30]);
    }
}
