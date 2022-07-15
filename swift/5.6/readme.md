# Swift playground

Example code and note from following the language guide for Swift 5.6

## Journeys

### Welcome to Swift

- [x] About Swift
- [x] Version Compatibility
- [x] A Swift Tour

`mutating` keywords is used on `protocol` and `struct` to allow modify struct
data. `struct` is immutable by default. `class` doesn't need such keyword as
it's pointer to a memory area.

Floating point number are always TRUNCATED when convert to Int:

- Positive: 1.99 -> 1
- Negative: -3.9 -> -3

Tuple components can be _partially_ named.

```swift
err404 = (code: 404, desc: "not found", "more detail here")
```

Function is first-class data type, but we can't just `return func ...`, we have
to declare the nested function first then return its name.

- Compile

```swift
func adj(d: Int) -> (Int) -> Int {
  func fn(x: Int) -> Int { x + d }
  return fn
}
```

- Won't compile

```swift
func adj(d: Int) -> (Int) -> Int {
  return func (x: Int) -> Int { x + d }
}
```

- However, this compiles:

```swift
func adj(d: Int) -> (Int) -> Int {
  { x in
    x + d
  }
}
```

- This compiles as well

```swift
func adj(d: Int) -> (Int) -> Int {
  { x in
    x + d
  }
}
```

- So is

```swift
func adj(d: Int) -> (Int) -> Int {
  { $0 + d }
}
```

### Language Guide

- [x] The Basics

  - Constants and Variables
  - Integers
  - Floating-Point Numbers
  - Type Safety and Type Inference
  - Number Literals
  - Numeric Type Conversion
  - Type Aliases
  - Booleans
  - Tuples
  - Options
  - Error Handling
  - Assertions and Preconditions
    - **NOTE**:
      - Swift has macro, e.g `#file` and `#line`, for source level info.
      - Assertions only for debug, Preconditions also for production.
      - `precondition` can be optimized out during production build with
        `-Ounchecked`, but `fatal*` is not.

- [x] Basic Operators

  - Terminology
  - Assignment Operators
  - Arithmetic Operators
    - Remainder `%` in Swift is strictly a remainder operator for negative
      number. `-11 % 3 == -2` in Swift (and Go, Java, JS), but the result is 1 for
      Python). Seems like Python is the weird one.
  - Compound Assignment Operators
  - Comparison Operators
    - There's also **identify** operators like JS for object: `===` and `!==`
  - Ternary Condition Operator
  - Nil-Coalescing Operator:
    - `a ?? b` unwraps `a` if it's not nil, or return b
  - Range Operators
    - `1..<10` and `1...10`
    - One-sided ranges: `nums[2...]` (start from 2),`nums[...2]` (until 2),
      `nums[..<2]` (stop before 2)
  - Logical Operators
  - No overflow by default, thus, **overflow become runtime failure**.

- [x] Strings and Characters

  - String Literals
    - Multi lines literals in Swift auto trim new line, unlike Go.
    - Can ignore new-line from multi-lines literals as well, via back slash.
    - String in Swift is not null-terminated.
    - Extended String Delimiters, even more _literals_: `#"not \n break"#`
  - String Mutability
    - Strings are passed by value.
  - Working with Characters
    - **TODO**: how about `StringBuilder`, do we need one?
  - String Interpolation
    - **TODO**: how to use `Timer` with console app? Need to build a CLI process
      bar!
    - Oh, this section mentions nothing about `printf` style function. What a
      complicated language! Every typical things are very very hard to do in
      Swift.
  - Unicode
    - **Extended Grapheme Clusters** make counting **visible** characters a
      challenge. String `.count` in Swift returns the visible characters, thus,
      string con-cat might not affect the count.
  - Accessing and Modifying a String
  - Insert and Removing
  - Substrings
    - For performance optimization, they can reuse part of mem for the parent
      strings. Such mem is copied only when the `Substring` is converted to
      `String`.
    - Use for short-term only. Otherwise, entire `String` will stay in memory
      until all `Substring` are removed.
  - Unicode Representations of Strings

- [x] Collection Types

  - Mutability of Collections
  - Arrays
    - Can update multi elements via `arr[2..4] = [1, 2]`
  - Set:
    - Doesn't have shorthand syntax, still use `[]` syntax for literal
    - `Set.enumerated()` doesn't have fixed order.
  - Dictionaries
    - Dict and Set key must be `Hashsable`

- [x] Control Flow

  - For-In Loops
    - Use `stride(from:to:by:)` to for loop with step
  - While Loops
    - `repeat {...} while ...`, because `do` is used with `catch`
  - Conditional Statements

    - If
    - Switch

      - No implicit fall through
      - Range/Tuple matching
      - Can use `let` and `where` for condition matching

      ```swift
      switch x {
      case _ where x < 0:
        print("negative")
      case let x where x < 5:
        print("less than 5")
      default:
        print("5 or more")
      }
      ```

  - Control Transfer Statements

- [x] Functions

  - Defining and Calling Functions
  - Function Parameters and Return Values
  - Specifying Argument Labels
  - Variadic Parameters
    - Support function with multiple variadic parameters.
  - In-out parameters

    - Can swap var using tuples

    ```swift
    var a = 1, b = 2
    (b, a) = (a, b)
    ```

  - Function Types
    - Made up of params types and return type

- [x] Closures

  - Example

  ```swift
  typealias Op = (Int, Int) -> Int

  let add: Op = { $0 + $1}
  let sub: Op = { $0 - $1}

  let call = { (a, b, op: Op) in
      op(a, b)
  }

  print(call(1,2, add))
  print(call(2,3, sub))
  ```

  - Closure Expressions

  ```swift
  let a = [2, 3, 1]
  _ = a.sorted(by: { (a: Int, b: Int) -> Bool in a > b })
  _ = a.sorted(by: { (a, b) in a > b })
  _ = a.sorted(by: { $0 > $1 })
  _ = a.sorted(by: > ) // operator method of Int
  ```

  - Trailing Closures
    - "Write the closure after the closing parentheses". So this is what make
      Swift code hard to read and understand what is params, what be method body.
  - Capturing Values
  - Escaping Closures
    - `@escape` is used for a closure that is a param to a function but will be
      called once that function returns.
    - Escaping closures can't capture mutable reference of `self` for Struct or
      Enum.
  - Autoclosures
    - `@autoclosure`: helpful to _delay_ the expression evaluation until needed
      (e.g. `assert` only evaluates its `condition` in debug mode, and then, only
      evaluates `message` if `condition` fail)

- [x] Enumerations

  - Enumeration Syntax
  - Matching Enumeration Values with a Switch Statement
  - Iterating over Enumeration Cases
    - Use `CaseIterable` protocol
      - **TODO**: how to define such powerful protocol where property value is
        auto defined?
  - Associated Values
  - Raw Values
  - Recursive Enumerations
    - Use `indirect` keyword before `case` or `enum`.

- [x] Structures and Classes

  - Comparing Structures and Classes
    - Prefer `struct` and `enum` over `class`.
  - Structure and Class Instances
  - Structures and Enumerations Are Value Types
  - Classes Are Reference Types

- [x] Properties

  - Stored Properties
    - Lazy Stored Properties
      - Use `lazy` to delay property initialization until first use. **Not
        thread safe**
  - Computed Properties
    - Read-only Computed Properties
      - Still must be declared via `var`.
      - Can omit the `get` part, write only the closure part. Again, Swift has
        too many shortcut that makes the code hard to read.
  - Property Observers
    - `willSet` and `didSet` **will always called for properties of `inout`
      params** due to copy-in, copy-out memory model.
  - Property Wrappers
    - Use `@propertyWrapper` to define a struct for validation and mutation
      logics that can later be used antoher annotation on other properties.
    - Feel like we could use this to implement validation annotations like in
      Java.
    - The exposed property of `@propertyWrapper` must be `wrappedValue` and the
      projected value (of any type) must be `projectedValue`. Swift has too many
      magic words (`newValue`, `rawValue`, and now these)
  - Global and Local Variables
    - Any variables can have accompany properties now. Properties, after all,
      are just syntax sugar for functions.
    - Property wrapper can be applied on local variable.
  - Type Properties
    - Basically `static` field or class level properties in other language.
    - Guaranteed to be initialized once on first access, no need `lazy`.

- [x] Methods

  - Instance Methods
  - Type Methods
    - Use `static` before `func` for `struct`. For class, seems like using
      `static` won't allow subclasses to override it, thus, the need of using
      `class` keyword.
    - `@discardableResult` is used to allow a function that return some value to
      be called with using its result. Such things are called _Attribute_ in
      Swift (not Annotation).

- [x] Subscripts

  - A new keyword `subscript`, damn! It can be used with `get` and `set`, too.
  - It's a function, not a property, although, technically not a _single_
    function if we support `set` as well. It could take any number of arguments
    of any type. However, it can't take `inout` param.
  - There's _Type Subscripts_, too. Useful for get `enum` instance by
    `rawValue`.

- [x] Inheritance

  - Defining a Base Class
    - Swift class doesn't have a universal base class (unlike JVM languages)
  - Subclassing
    - Swift doesn't allow multi-inheritance (doesn't mention in the book yet)
  - Overriding
    - Can't use `didSet` or `willSet` with `set`, because if we have setter, we
      might as well implement the logic of `didSet` and `willSet` in that
      setter.
  - Preventing Overrides
    - Oh, so Swift has `final` keyword, too.

- [x] Initialization

  - Setting Initial Values for Stored Properties
  - Default Initializers
  - Class Inheritance and Initialization

    - Read [this SO answer](https://stackoverflow.com/a/36612507/3869533),
      still don't find `convenience` keyword necessary or helpful. Swift is
      really weird. This comment really said it better than me

      > From what I experienced being part of Swift community, the fact that
      > the language compilation is quite complicated comparing to most other
      > compiled languages, many people in this community lost connection to
      > what is a programmer API and what is a compiler API. Some decisions are
      > really questionable and convenience keyword is one of them. I
      > personally see no useful insight to have it in my code. Just as with
      > indirect keyword for enums, @escaping closures and some other keywords.

      Perhaps I'm learning Swift too late. Someone also finds Swift complicated:
      https://news.ycombinator.com/item?id=30418368

  - Failable Initializers
    - `enum` can have `init`, too.
    - Can `override` a `init?` with a `init` in subclass, but not the other way.

- [x] Deinitialization

- [x] Optional Chaining

  - Function without any return means return `Void`, which in turn is **a
    non-nil empty tuple**.

- [x] Error Handling

  - `defer` executes at block level, not function level.
  - There's no `finally` keyword in Swift, use `defer` instead.

- [x] Concurrency

  - Side note: how can the Books app is so bad? Unhelpful navigation,
    uncontrollable via just the keyboard.

  - Defining and Calling Asynchronous Functions
    - WTF is this syntax? `add(firstPhoto toGallery: "Road Trip")`. Why there's
      no comma between `firstPhoto` and `toGallery`.
  - **A whole chapter without any CLI executable code!** Do we suppose to try
    all that code in iOS or macOS app to understand? Compare to Go, the way
    Swift handle concurrency is just incomprehensible.
  - **TODO**: Learn this shit again, need to build some things to be sure.

- [x] Type Casting

  - Defining a Class Hierarchy for Type Casting
  - Checking Type
    - `is`
  - Downcasting
    - `as?` or `as!`
  - Type Casting for `Any` and `AnyObject`

- [x] Nested Types
- [x] Extensions

- [x] Protocols

  - Seem like the Delegate patterns make it too easy to hit reference cycle,
    hence, we need to explicitly use weak reference via `weak` keyword to avoid
    that.
  - > Types don’t automatically adopt a protocol just by satisfying its
    > requirements. They must always explicitly declare their adoption of the
    > protocol.

  - Poor man auto `toString`, doesn't work really well, though

  ```swift
  protocol Describable: CustomStringConvertible {}

  extension Describable {
    var properties: [String: String] {
      var props: [String: String] = [:]

      func addProps(m: Mirror) {
        m.children.forEach { p, v in
          if let p = p {
            props[p] = v is Describable ? (v as! Describable).description : String(describing: v)
          }
        }

        if let sup = m.superclassMirror {
          addProps(m: sup)
        }
      }

      let m = Mirror(reflecting: self)
      addProps(m: m)
      return props
    }

    var description: String {
      let s = properties.description
      return "{" + String(s[s.index(after: s.startIndex)..<s.index(before: s.endIndex)]) + "}"
    }
  }
  ```

- [x] Generics

  - `where` can be used with `extension`, `protocol` and `func`

- [x] Opaque Types

  - Make function return `some` type. Very similar with return a protocol type
    directly, but not the same.

    - "The less specific return type ... means that many operations that depend
      on type information aren’t available on the returned value"

    ```swift
    let protoFlippedTriangle = protoFlip(smallTriangle)
    let sameThing = protoFlip(smallTriangle)
    protoFlippedTriangle == sameThing  // Error
    ```

    The example code doesn't make sense, because it also doesn't work with the
    flip function that returns `some Shape`. Better example:

    ```swift
    let t = Triangle(3)
    print(type(of: flip(t))) // Flipped
    print(type(of: protoFlip(t))) // Flipped, so we have runtime info for both
    print(flip(flip(t))) // OK
    print(protoFlip(flip(t))) // OK
    print(flip(protoflip(t))) // Err: 'Shape' as a type can't conform to the protocol itself
    print(protoFlip(protoFlip(t))) // Err: 'Shape' as a type can't conform to the protocol itself
    ```

    **TODO**: study this answer for why https://stackoverflow.com/a/43408193/3869533
    Swift type system is quite weird!

  - If a function has multiple `return`, all result must be **exact same type**

- [ ] Automatic Reference Counting

  - Property observers aren’t called when ARC sets a weak reference to `nil`.
  - `weak` is used when the other object (to be referenced) has shorter lifetime.
  - `unowned` is used when the other object has equal or longer lifetime.
  - Use `unowned` and an unwrapped optional in case both need to live together
    and not nil.
  - Shit, now we have a new syntax: Closure capture list. Honest, this just show
    that the Swift compiler is not smart enough to detect and such cases and
    force the developer to explicitly manage them.

- [x] Memory Safety

- [x] Access Control

  - There's only module and source file boundary levels. Folders within a module
    don't help restrict anything.
  - 5 levels of access:
    - `open`: allow inherit and override
    - `public`: default level, optional keyword, can't inherit or override.
      - Even so, `public` type members are still `internal` by default.
    - `internal`
    - module `private`
    - source `fileprivate`

- [x] Advanced Operators
  - Bitwise Operators
    - And `&`, OR `|`, XOR `^`, NOT `~`, Left Shift `<<`, Right Shift `>>`
  - Overflow Operators
  - Precedence and Associativity
  - Operators Methods
  - Custom Operators
  - Apparently, `@resultBuilder` is the compiler magic annotation/type/whatever
    Swift has to introduce to support SwiftUI. Oh, we **can't** view doc or jump
    to definition of that annotation in neither XCode or AppCode

### Language Reference

Skip this.

## TODO

= singleton, other design patterns?

- json/yaml encode/decode
- meta programming using `didSet`, `willSet`
