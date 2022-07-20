# Code sample from Apple tutorials

## Setup

I need to enforce code formating to be more readable. Because Xcode is so shitty
that it can't even format code nicely, I use some script to use `swift-format`
on the command line with some [custom config](./swift-format.json).

Here's how:

- Install [swift-format](https://github.com/apple/swift-format) is installed
  (why don't swift just include this tool by default?)

  ```sh
  $ brew install swift-format
  ```

- Install [`modd`](https://github.com/cortesi/modd) to watch for file changes.
  Sadly, nodemon doesn't handle this use case well. `modd` will load its config
  from [`modd.conf`](./modd.conf) and execute `./scripts/fmt.sh` on `*.swift`
  files.

- Because `modd` is too sensitive to file changes, we need `--in-place` flag to
  save formatted code, and `--in-place` modifies the file even without any
  changes needed, `scripts/fmt.sh` has to call `swift-format` in 2 passes (if
  there's only a single argument): first pass check whether the file will
  changes again after formatting, if not, stop, otherwise, do the formatting.
  When `modd` picks up the change later due to second pass, it call
  `scripts/fmt.sh` again. This time, the script won't touch the file.

## Introducing SwiftUI

https://developer.apple.com/tutorials/SwiftUI

Code: [`./Landmarks`](./Landmarks)

## Learning SwiftUI

https://developer.apple.com/tutorials/swiftui-concepts
