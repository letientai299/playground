Folder structure

```
$ tree -a -I .idea
.
├── .dir
│   ├── .hidden
│   ├── .txt
│   └── a.txt
├── .hidden
├── dir
│   ├── .hidden
│   ├── .txt
│   └── a.txt
├── go.mod
├── main.go
└── readme.md

2 directories, 10 files
```

Output:

```
$ go run main.go
2021/03/17 19:14:28 .hidden: content of .hidden
2021/03/17 19:14:28 dir/a.txt: content of a.txt
2021/03/17 19:14:28 dir/.txt:
2021/03/17 19:14:28 dir/.hidden: content of .hidden
2021/03/17 19:14:28 .dir/a.txt: content of a.txt
2021/03/17 19:14:28 .dir/.txt:
2021/03/17 19:14:28 .dir/.hidden: content of .hidden
```
