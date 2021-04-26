// Package preact provides bindings to the preact library.
package preact

import "github.com/gopherjs/gopherjs/js"

var preact = js.Global.Get("preact")

// Attrs of an element.
type Attrs map[string]interface{}

// H returns a new element.
func H(v ...interface{}) *js.Object {
	return preact.Call("h", v...)
}

// Render function.
func Render(args ...interface{}) {
	preact.Call("render", args...)
}