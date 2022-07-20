#!/bin/bash

cmd='swift-format --configuration ./swift-format.json'

if [ $# -ne 1 ]; then
  # format all
  $cmd --in-place "$@"
  exit $?
fi

# first pass to check if file need change
formatted=$($cmd "$1")
needInPlace=$($cmd "$1" | diff "$1" -)
if [ ! -z "$needInPlace" ]; then
  $cmd --in-place "$1"
fi
