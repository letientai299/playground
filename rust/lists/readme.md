# Learning Rust With Entirely Too Many Linked Lists

https://rust-unofficial.github.io/too-many-lists

- `std::mem::replace` moves value from `src` to `dst` and return old `dst`.
- Can't return `&T` or part of it from `Rc<RefCell<T>>` safely since it will break
  ownership rules: https://users.rust-lang.org/t/it-it-possible-to-extract-and-return-t-from-optionrefcellsmthg/39289/3
  Must return `Ref<T>` instead.
- [`miri`](https://github.com/rust-lang/miri) can help detect certain classes of
  undefined behavior with `unsafe`.

- Can re-borrow mutable reference! But subsequent borrower must go stop being
  used first.

  ```rust
  let mut data = 10;
  let ref1 = &mut data;
  let ref2 = &mut *ref1;
  ```
