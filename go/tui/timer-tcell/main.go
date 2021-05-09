package main

import (
	"fmt"
	"log"
	"strings"
	"time"

	"github.com/common-nighthawk/go-figure"
	"github.com/gdamore/tcell/v2"
)

func main() {
	tcell.SetEncodingFallback(tcell.EncodingFallbackASCII)
	s, err := tcell.NewScreen()
	t := &timer{screen: s}

	if err != nil {
		log.Fatalln(err)
	}

	if err = s.Init(); err != nil {
		log.Fatalln(err)
	}

	quit := make(chan struct{})
	go func() {
		for {
			switch event := s.PollEvent(); ev := event.(type) {
			case *tcell.EventKey:
				key := ev.Key()
				if key == tcell.KeyEscape || ev.Rune() == 'q' || key == tcell.KeyCtrlC {
					close(quit)
					return
				}
			case *tcell.EventResize:
				s.Sync()
			}
		}
	}()

	dur := time.Duration(0)
	tick := time.Tick(time.Second)
loop:
	for {
		select {
		case <-quit:
			t.screen.Clear()
			t.screen.Fini()
			break loop
		case <-tick:
			dur += time.Second
			t.display(dur)
		}
	}
	fmt.Printf("Duration: %v\n", dur)
}

type timer struct {
	screen tcell.Screen
}

func (t *timer) display(dur time.Duration) {
	t.screen.Clear()
	raw := dur.String()
	fig := figure.NewFigure(raw, "big", true)
	t.emitStr(fig.String(), raw)
	t.screen.Sync()
}

func (t *timer) emitStr(fig string, raw string) {
	x, y := t.screen.Size()
	lines := strings.Split(fig, "\n")
	if len(lines) > y {
		t.emitRaw(x, y, raw)
		return
	}

	runeLines := make([][]rune, 0, len(lines))
	maxLen := 0
	for _, line := range lines {
		rs := []rune(line)
		runeLines = append(runeLines, rs)
		if len(rs) > maxLen {
			maxLen = len(rs)
		}

		if maxLen > x {
			t.emitRaw(x, y, raw)
			return
		}
	}

	x = x/2 - maxLen/2
	y = y/2 - len(runeLines)/2
	for i, rs := range runeLines {
		t.screen.SetCell(x, y+i, tcell.StyleDefault, rs...)
	}
}

func (t *timer) emitRaw(w int, h int, raw string) {
	n := len(raw)
	w = w/2 - n/2
	t.screen.SetCell(w, h/2, tcell.StyleDefault, []rune(raw)...)
}
