# Rust by example

## 1. Hello World

`print!()` and other marco are quite powerful:

- Can refer to variable by number or name
- Use `:<format>` to choose formatter. Formatter can refer to variable as well.

## 2. Primitives

- Long tuples can't be printed. Current limit is 12 elements.
- Slices (`[T]`) are similar to arrays (`[T; length]`), but their length is not
  known at compile time.
- Arrays are **stack-allocated**.

## 3. Custom Types

- There is `type` alias.
- There is `static` keyword for `mut` variable with `'static` lifetime.

## 4. Variable Bindings

- Can freeze a `mut` variable via shadowing within smaller scope.

## 5. Types

Done

## 6. Conversion

- `Into` is implemented automatically from `From`.
- `TryInto` and `TryFrom` is similar but above, but return `Result`.
- `ToString` is provided automatically via `Display`.
- `parse` uses `FromStr` implementation.

## 7. Expressions

Done

## 8. Flow of Control

- `for` by default apply `into_iter()`, which **consume** the list, make it
  unusable afterward.
- `match` arm can be:
  - `1 | 2 | 3`: multi value
  - `1..10`: range
  - Match guard is `if <condition>` after the arm.
  - Can destructure array like this `[first, middle @ .., last]`.

## 9. Functions

- Use `-> impl Fn` or the other 2 to return closure.
- Function that never returns is marked with `-> !`.

## 10. Modules

Done

## 11. Crates

Done

## 12. Cargo

Done

## 13. Attributes

Done

## 14. Generics

Done

## 15. Scoping rules

- **RAII**: Resource Acquisition Is Initialization
- If lifetime is never constrained, it's default to `'static`.
- `func<'a: 'b, 'b'>` means lifetime `'a` is at least as long as `'b`.

## 16. Traits

- Fully qualified syntax for overlapping traits: `<Form as Widget>::get()`

## 17. macro_rules!

- Unlike macros in C and other languages, Rust macros are expanded into
  **abstract syntax trees**, rather than string preprocessing.
- Rust doesn't support variadic function. Need macro for this.

## 18. Error handling

Done

## 19. Std library types

- Use [indoc](https://crates.io/crates/indoc/1.0.7) for indented raw string.
- `HashMap`
- `HashSet`
- `Rc`: reference counting, for when multiple ownership is required, single
  threaded. `Arc` (atomic RC) should be used for multi-threaded program.

## 20. Std misc

- Threads can return the result from its closure param.
- There's a channel mechanism in Rust.
- `Path` is internally stored as `Vec<u8>`, thus, convert to `&str` is not free.

## 21. Testing

Done

## 22. Unsafe Operations

Done

## 23. Compatibility

Done

## 24. Meta

Done
