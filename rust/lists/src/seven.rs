#![allow(unused)]

use std::marker::PhantomData;
use std::ptr;
use std::ptr::NonNull;

struct LinkedList<T> {
    front: Link<T>,
    back: Link<T>,
    len: usize,

    /// marker field of zero-size type to hint to compiler that
    /// our list **own** T.
    _boo: PhantomData<T>,
}

type Link<T> = Option<NonNull<Node<T>>>;

struct Node<T> {
    elem: T,
    front: Link<T>,
    back: Link<T>,
}

impl<T> Drop for LinkedList<T> {
    fn drop(&mut self) {
        while self.pop_front().is_some() {}
    }
}

impl<T> LinkedList<T> {
    pub fn new() -> Self {
        Self {
            front: None,
            back: None,
            len: 0,
            _boo: PhantomData,
        }
    }

    fn push_front(&mut self, v: T) {
        unsafe {
            let mut new = NonNull::new_unchecked(Box::into_raw(Box::new(Node {
                front: None,
                back: None,
                elem: v,
            })));

            if let Some(old) = self.front.take() {
                (*old.as_ptr()).front = Some(new);
                (*new.as_ptr()).back = Some(old);
            } else {
                debug_assert!(self.back.is_none());
                debug_assert!(self.front.is_none());
                debug_assert!(self.len == 0);
                self.back = Some(new);
            }

            self.len += 1;
            self.front = Some(new);
        }
    }

    fn pop_front(&mut self) -> Option<T> {
        unsafe {
            self.front.map(|node| {
                let boxed_node = Box::from_raw(node.as_ptr());

                self.front = boxed_node.back;
                if let Some(new) = self.front {
                    (*new.as_ptr()).front = None;
                } else {
                    debug_assert!(self.len == 1);
                    self.back = None
                }

                self.len -= 1;
                boxed_node.elem
            })
        }
    }

    fn len(&self) -> usize {
        self.len
    }

    fn front(&self) -> Option<&T> {
        unsafe { self.front.as_ref().map(|node| &node.as_ref().elem) }
    }

    fn back(&self) -> Option<&T> {
        unsafe { self.back.as_ref().map(|node| &node.as_ref().elem) }
    }

    fn front_mut(&mut self) -> Option<&mut T> {
        unsafe { self.front.as_mut().map(|node| &mut node.as_mut().elem) }
    }

    fn back_mut(&mut self) -> Option<&mut T> {
        unsafe { self.back.as_mut().map(|node| &mut node.as_mut().elem) }
    }
}

#[cfg(test)]
mod test {
    use super::LinkedList;

    #[test]
    fn test_basic_front() {
        let mut list = LinkedList::new();

        // Try to break an empty list
        assert_eq!(list.len(), 0);
        assert_eq!(list.pop_front(), None);
        assert_eq!(list.len(), 0);

        // Try to break a one item list
        list.push_front(10);
        assert_eq!(list.len(), 1);
        assert_eq!(list.pop_front(), Some(10));
        assert_eq!(list.len(), 0);
        assert_eq!(list.pop_front(), None);
        assert_eq!(list.len(), 0);

        // Mess around
        list.push_front(10);
        assert_eq!(list.len(), 1);
        list.push_front(20);
        assert_eq!(list.len(), 2);
        list.push_front(30);
        assert_eq!(list.len(), 3);
        assert_eq!(list.pop_front(), Some(30));
        assert_eq!(list.len(), 2);
        list.push_front(40);
        assert_eq!(list.len(), 3);
        assert_eq!(list.pop_front(), Some(40));
        assert_eq!(list.len(), 2);
        assert_eq!(list.pop_front(), Some(20));
        assert_eq!(list.len(), 1);
        assert_eq!(list.pop_front(), Some(10));
        assert_eq!(list.len(), 0);
        assert_eq!(list.pop_front(), None);
        assert_eq!(list.len(), 0);
        assert_eq!(list.pop_front(), None);
        assert_eq!(list.len(), 0);
    }
}
