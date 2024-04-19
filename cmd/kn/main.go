package main

import (
	"fmt"

	"github.com/cardil/knative-multimodule-release-check/pkg/plugin"
)

func main() {
	p := &plugin.Plugin{Name: "World"}
	fmt.Printf("Hello, %#v!\n", p)
}
