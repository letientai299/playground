# Lesson learned

- Unlike in Java, `Stream` is always async. There's no sync stream in Dart.
- `dart:async` is imported implicitly, which might hide the fact above for
  beginner.
- We can use `await for (var x in stream)` but can't do normal `for in` because
  `Stream` is `async`.
