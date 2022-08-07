use std::fmt::{Display, Formatter};
use std::ops::Deref;

use crate::list::List::{End, Next};

enum List<T> {
    Next(T, Box<List<T>>),
    End,
}

impl<T> List<T> {
    #[allow(dead_code)]
    fn append(self, item: T) -> Self {
        match self {
            End => Next(item, Box::new(End)),
            // probably bad for performance since we recreate the whole list.
            Next(t, tail) => Next(t, Box::new(tail.append(item))),
        }
    }

    #[allow(dead_code)]
    fn prepend(self, item: T) -> Self {
        Next(item, Box::new(self))
    }

    #[allow(dead_code)]
    fn len(&self) -> u32 {
        match self {
            Next(_, tail) => 1 + tail.len(),
            End => 0,
        }
    }
}

impl<T: Display> Display for List<T> {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            End => write!(f, "end"),
            Next(item, tail) => {
                write!(f, "{} -> ", item)?;
                tail.deref().fmt(f)
            }
        }
    }
}

impl<T: Copy, const N: usize> From<[T; N]> for List<T> {
    fn from(slice: [T; N]) -> Self {
        List::from(slice.as_slice())
    }
}

impl<T: Copy> From<&[T]> for List<T> {
    fn from(slice: &[T]) -> Self {
        if slice.is_empty() {
            return End;
        }

        let tail = List::from(&slice[1 ..]);
        Next(slice[0], Box::new(tail))
    }
}

#[cfg(test)]
mod tests {
    use crate::list::*;

    #[test]
    fn slice_into_list() {
        let slice = [1, 2, 3];
        let list: List<i32> = slice.into();
        assert_eq!("1 -> 2 -> 3 -> end", format!("{}", list));
    }

    #[test]
    fn list_append() {
        let list = List::from([1, 2, 3]);
        let list = list.append(0).append(-1);
        assert_eq!("1 -> 2 -> 3 -> 0 -> -1 -> end", format!("{}", list));
    }

    #[test]
    fn list_prepend() {
        let list = List::from([1, 2, 3]);
        let list = list.prepend(0).prepend(-1);
        assert_eq!("-1 -> 0 -> 1 -> 2 -> 3 -> end", format!("{}", list));
    }

    #[test]
    fn list_len() {
        let list = List::from([1, 2, 3, 4]);
        assert_eq!(4, list.len());
    }

    #[test]
    fn list_fmt() {
        let list = List::from([1, 2, 3]);
        assert_eq!("1 -> 2 -> 3 -> end", format!("{}", list));
        assert_eq!("end", format!("{}", End::<i32>));
    }
}
