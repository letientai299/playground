if CommandLine.argc < 2 {
    say(name: "... who?")
} else {
    let name = CommandLine.arguments[1]
    say(name: name)
}

print("Done")