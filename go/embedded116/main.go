package main

import (
	"embed"
	_ "embed"
	"io/ioutil"
	"log"
	"path"
)

//go:embed .hidden
var hidden string

//go:embed dir/*
var dir embed.FS

//go:embed .dir/*
var dotdir embed.FS

func main() {
	log.Printf(".hidden: %s", hidden)
	showDir("dir", dir)
	showDir(".dir", dotdir)
}

func showDir(dir string, f embed.FS) {
	showFile(dir, f, "a.txt")
	showFile(dir, f, ".txt")
	showFile(dir, f, ".hidden")
}

func showFile(dir string, f embed.FS, file string) {
	p := path.Join(dir, file)
	a, err := f.Open(p)

	if err != nil {
		log.Fatalf("fail to open %s, err=%v", p, err)
		return
	}

	s, err := ioutil.ReadAll(a)
	if err != nil {
		log.Fatalf("fail to read file %s, err=%v", p, err)
		return
	}

	log.Printf("%s: %s", p, s)
}
