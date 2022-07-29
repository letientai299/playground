#!/usr/bin/env bash

rustc -o $TMPDIR/rust_main $1
$TMPDIR/rust_main
