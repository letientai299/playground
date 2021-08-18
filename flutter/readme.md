## Flutter general notes

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
