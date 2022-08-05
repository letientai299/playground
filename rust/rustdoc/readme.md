# `rustdoc`

- [x] 1. What is rustdoc?
  - While `rustdoc` supports standalone Markdown file, `cargo` doesn't.
- [x] 2. Command-line arguments
- [x] 3. How to read rustdoc output
- [x] 4. How to write documentation

  - [x] 4.1. What to include (and exclude)
  - [x] 4.2. The #[doc] attribute
  - `///` is syntax surgar for `#[doc]`
  - `#[doc]` can `include_str!` from external markdown file.
  - [x] 4.3. Linking to items by name
    - Rust doc markdown auto strips backtick: <code>[`Option`]</code> link to
      `Option`
  - [x] 4.4. Documentation tests

    - While to rust doc seems to have more features and handle Markdown nicely,
      I kind of prefer godoc example test since it feels more nature than write
      executable code in markdown.
    - Test doc in markdown file but doensn't show on Rust doc.

    ```rust
    #[doc = include_str!("../README.md")]
    #[cfg(doctest)]
    pub struct ReadmeDoctests;
    ```

- [x] 5. Rustdoc-specific lints
- [x] 6. Scraped examples
- [x] 7. Advanced features
- [x] 8. Unstable features
- [x] 9. Deprecated features
- [x] 10. References
