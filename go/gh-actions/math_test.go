package ghactions

import (
	"testing"
)

func Test_factorial(t *testing.T) {
	tests := []struct {
		n int
		f int
	}{
		{n: 0, f: 1},
		{n: 1, f: 1},
		{n: 2, f: 2},
		{n: 3, f: 6},
		{n: 4, f: 24},
	}

	for _, tc := range tests {
		tc := tc
		t.Run("", func(t *testing.T) {
			if actual := factorial(tc.n); actual != tc.f {
				t.Errorf("expect=%v, actual=%v", tc.f, actual)
			}
		})
	}
}
