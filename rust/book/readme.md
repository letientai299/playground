# Code and note for The Rust Book

https://doc.rust-lang.org/book/ch01-01-installation.html

## The Rust Programming Language

Done

## Foreword

Done

## Introduction

Done

## 1. Getting Started

- [x] 1.1. Installation
  - It's cool that Rust comes with a version manager and installer out of the
    box: `rustup`. Not many languages have it.
- [x] 1.2. Hello, World!
- [x] 1.3. Hello, Cargo!

## 2. Programming a Guessing Game

- _Trail_ must be **in scope** to use the function of it.
- Variables of different types can be **shadowed**.
- `rustfmt` config can be placed in parent dir

## 3. Common Programming Concepts

- File name in rust can have `.`, i.e. `3.1.code.rs` is invalid name.

- [x] 3.1. Variables and Mutability
  - `let`: immutable var _by default_, can use `let mut` to have mutable var
  - `const`: constant, can't use with `mut`,
- [x] 3.2. Data Types
  - 4 primary scala types: integers, float, bool and char.
  - Overflow handling: panic in debug mode, 2-complement wrapping in release.
  - `char` is 4 bytes in size, possible to represent Unicode Scalar Value, but
    doens't necesssary be a real characters (due to unicode graphene).
  - To print array `a`, use `{a:?}` or `println!({:?}, a)`
  - The "string interpolation" syntax is weak. This won't work:
    `println!("{a[1]}");`
  - Type of array index must be `usize`: **pointer-sized unsigned int**.
- [x] 3.3. Functions
- [x] 3.4. Comments
- [x] 3.5. Control Flow
  - Rust have `let ... = if ...`, doesn't need ternary operator.
  - `loop` can be an expression via `break <value>`.
  - `loop`, `for` and `while` can have label for breaking from nested loops.

## 4. Understanding Ownership

- [x] 4.1. What is Ownership?

  - Main purpose of Ownership is **managing heap data**.
  - Rules: **each value has an owner, one owner as a time, value is dropped if
    owner go out of scope**.
  - For reference-type data, assign variable is a **move**: shadow copying point
    data _and_ invalidate the orignal variable, leave only the assigned
    variable.
  - `Copy` trait can't be implemented if the type or any of its parts
    implemented `Drop` trait.
  - On `String` vs `str`: https://stackoverflow.com/a/24159933/3869533
    - `String`: owned heap allocated string
    - `str`: immutable fixed-length heap allocated sequence of UTF-8 bytes, can
      only used via pointer, mostly as `&str`
      - Literal string is `&'static str`
  - Functions either **move or copy** its params.

- [x] 4.2. References and Borrowing

  - `&s` creates a reference to `s` but doesn't own it. Thus, `s` is still
    valid, and won't be droped after the reference go out of scope.
  - Can't have multiple `&mut` simultaneously or `&mut` and `&` simultaneously.

- [x] 4.3. The Slice Type
  - String slide range indices must occurr at valid UTF-8 character boundaries.
  - Defining a function to take a string slice `&str` instead of `&String` make
    it more general and useful.

## 5. Using Structs to Structure Related Data

- [x] 5.1. Defining and Instantiating Structs
  - Here's how to partially destructuring a struct
  ```rust
  let User {
    username, email, .. // other fields, ...
  } = a;
  ```
- [x] 5.2. An Example Program Using Structs

  - `{:?}` for JSON like output
  - `{:#?}` for JSON like pretty print output
  - `dbg!()` macro is much nicer, print to `stderr`, but still requires opt-in
    for `#[derive(Debug)]`

- [x] 5.3. Method Syntax
  - `self` in method is when we want to prevent the instance to be used after
    calling the method. This is rare.
  - Rust doesnt have `static` mmethod like other language. It's instead a `fn`
    without `&self`.
  - `impl` can be within another function.

## 6. Enums and Pattern Matching

- [x] 6.1. Defining an Enum
- [x] 6.2. The match Control Flow Construct
- [ ] 6.3. Concise Control Flow with if let

## 7. Managing Growing Projects with Packages, Crates, and Modules

- [x] 7.1. Packages and Crates
  - `src/main.rs` indicates that the package is a binary crate
  - `src/lib.rs` indicates that the package is a lib crate
- [x] 7.2. Defining Modules to Control Scope and Privacy
- [x] 7.3. Paths for Referring to an Item in the Module Tree
  - If we have both `main.rs` and `lib.rs`, the module tree should be defined in
    `lib.rs`.
- [x] 7.4. Bringing Paths Into Scope with the use Keyword
  - Convention: use `::` to call non-local function, thus:
    - `use` up to module name, then call `module::func`
    - `use` up to struct, enum name, then call `Enum::func`
  - `pub use` to re-export and also adjust how the users call to internal module.
- [x] 7.5. Separating Modules into Different Files

## 8. Common Collections

- [x] 8.1. Storing Lists of Values with Vectors
- [x] 8.2. Storing UTF-8 Encoded Text with Strings
  - Getting grapheme is not supported natively in Rust.
- [x] 8.3. Storing Keys with Associated Values in Hash Maps
  - Default hash algo in Rust is SipHash to prevent DoS.

## 9. Error Handling

- [x] 9.1. Unrecoverable Errors with panic!
- [x] 9.2. Recoverable Errors with Result
  - `?` can be used only with `Result`,`Option` or types that implement
    `FromResidual`.
  - To convert between `Option` and `Result`, use `Ok()` and `.ok_or()`.
  - `main` can return anythign that implement `Termination` trait.
- [x] 9.3. To panic! or Not to panic!

## 10. Generic Types, Traits, and Lifetimes

**This is hardest chapter so far.**

- [x] 10.1. Generic Data Types

  - Rust generic uses **Monomorphization**: compiler generates different copy of
    the generic function using the concrete type. This makes the binary size
    bigger, compiling slower, might affect CPU cache. Go uses this partially, mix
    with the other technique that make function operates on pointer to data, and
    pointer will be resolved at runtime.

- [x] 10.2. Traits: Defining Shared Behavior

  - It isn’t possible to call the default implementation from an overriding
    implementation of that same method.
  - OK, so we have several way to define the type on generic function, including
    the `where` keyword.
  - Return `-> imp SomeTrait` is similar to `some SomeProtocol` in Swift, all
    `return` must be of same type.
    - Also similar with `AnyView` or other help types in Swift, we can use `Box`
      in Rust to overcome the limitation. Must use `Box<dyn SomeTrait>`, though.

- [x] 10.3. Validating References with Lifetimes
  - **Owned Types**: variable that own the value, assign means move.
  - **Borrowed Types**: mostly reference type, variable has `&` prefix, can only
    refer to value, doesn't own it.

## 11. Writing Automated Tests

- [x] 11.1. How to Write Tests
  - Built-in test features in Rust is much less useful than Go. There's no
    built-in benchmark (yet, it's on unstable channel), no table-driven test, no
    rexgex matching support for panic message (Go doens't have this built-in,
    but at least we can implement it easily via `defer` and `recover`).
- [x] 11.2. Controlling How Tests Are Run
  - There's no `t.Skip()` to ignore test programmatically.
  - Clion can't generate Rust test.
- [x] 11.3. Test Organization
  - Unit tests live in `src`, in each file they're testing. the convention is
    use module `tests` and `cfg(test)`
  - `tests` folder is for integration test.
    - Files in subdirectories of the `tests` directory don’t get compiled as
      separate crates or have sections in the test output. Put common util in
      these sub directories instead.

## 12. An I/O Project: Building a Command Line Program

- [x] 12.1. Accepting Command Line Arguments
  - Shit, `env::args()` will panic if input contains Unicode.
- [x] 12.2. Reading a File
- [x] 12.3. Refactoring to Improve Modularity and Error Handling
  - Using `()` is the idiomatic way to indicate that we’re calling `run`
    for its side effects only
- [x] 12.4. Developing the Library’s Functionality with Test Driven Development
- [x] 12.5. Working with Environment Variables
- [x] 12.6. Writing Error Messages to Standard Error Instead of Standard Output

## 13. Functional Language Features: Iterators and Closures

- [ ] 13.1. Closures: Anonymous Functions that Can Capture Their Environment
- [ ] 13.2. Processing a Series of Items with Iterators
- [ ] 13.3. Improving Our I/O Project
- [ ] 13.4. Comparing Performance: Loops vs. Iterators

## 14. More about Cargo and Crates.io

- [ ] 14.1. Customizing Builds with Release Profiles
- [ ] 14.2. Publishing a Crate to Crates.io
- [ ] 14.3. Cargo Workspaces
- [ ] 14.4. Installing Binaries from Crates.io with cargo install
- [ ] 14.5. Extending Cargo with Custom Commands

## 15. Smart Pointers

- [ ] 15.1. Using Box<T> to Point to Data on the Heap
- [ ] 15.2. Treating Smart Pointers Like Regular References with the Deref Trait
- [ ] 15.3. Running Code on Cleanup with the Drop Trait
- [ ] 15.4. Rc<T>, the Reference Counted Smart Pointer
- [ ] 15.5. RefCell<T> and the Interior Mutability Pattern
- [ ] 15.6. Reference Cycles Can Leak Memory

## 16. Fearless Concurrency

- [ ] 16.1. Using Threads to Run Code Simultaneously
- [ ] 16.2. Using Message Passing to Transfer Data Between Threads
- [ ] 16.3. Shared-State Concurrency
- [ ] 16.4. Extensible Concurrency with the Sync and Send Traits

## 17. Object Oriented Programming Features of Rust

- [ ] 17.1. Characteristics of Object-Oriented Languages
- [ ] 17.2. Using Trait Objects That Allow for Values of Different Types
- [ ] 17.3. Implementing an Object-Oriented Design Pattern

## 18. Patterns and Matching

- [ ] 18.1. All the Places Patterns Can Be Used
- [ ] 18.2. Refutability: Whether a Pattern Might Fail to Match
- [ ] 18.3. Pattern Syntax

## 19. Advanced Features

- [ ] 19.1. Unsafe Rust
- [ ] 19.2. Advanced Traits
- [ ] 19.3. Advanced Types
- [ ] 19.4. Advanced Functions and Closures
- [ ] 19.5. Macros

## 20. Final Project: Building a Multithreaded Web Server

- [ ] 20.1. Building a Single-Threaded Web Server
- [ ] 20.2. Turning Our Single-Threaded Server into a Multithreaded Server
- [ ] 20.3. Graceful Shutdown and Cleanup

## 21. Appendix

- [ ] 21.1. A - Keywords
- [x] 21.2. B - Operators and Symbols
- [x] 21.3. C - Derivable Traits
- [ ] 21.4. D - Useful Development Tools
- [ ] 21.5. E - Editions
- [ ] 21.6. F - Translations of the Book
- [ ] 21.7. G - How Rust is Made and “Nightly Rust”
