# Flutter general notes

- On Macos, if iOS build fails with error related to C/C++ import path, check
  for `CPPFLAGS`, `CPATH`, ... variables.

- When define assets **folder** in `pubspec.yaml`, it's important to have the
  **trailing slash**.

  - This doesn't work.

  ```yml
  assets:
    - assets
  ```

  - This works

  ```yml
  assets:
    - assets/
  ```

## `map` and `foreach` WTF

This works:

```dart
// print list item per-line
list.forEach(print);
```

One might think that we can use the short function form with `map`, too, but
this won't work:

```dart
List<B> bs = listOfTypeA.map(toTypeB);
```

No, it won't, because `map` expects a function accept and returns `dynamic`, but
the function `toTypeB` doesn't.

## Decoding json array

This won't work:

```dart
final json = jsonDecode(responseBody);
List<Item> items = json['items'].map((e) => Item.fromJson(e));
```

Adding `toList()` also won't work:

```dart
final json = jsonDecode(responseBody);
List<Item> items = json['items'].map((e) => Item.fromJson(e)).toList();
```

It's because the type returned from `map` has something to do with `dynamic`. To
get a `List<Item>`, we must use `List.from()`.

```dart
List<Item> items = List<Item>.from(json['items'].map((e) => Item.fromJson(e)));
```
