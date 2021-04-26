LMD in 126 bytes
================

Big JavaScript application cause huge startup latency. A 1Mb of JavaScript initializes about ~600-3000ms! without touching any part of DOM. LMD is inspired by AMD and provides similar module interface. It evals module only when they are required.

1. Modules are similar to AMD: there is a require, but no define (all defined on startup) nor exports (module function returns object)
2. All modules are loaded at startup
3. Each function-module is initialized (evaled) on demand

Original LMD: https://github.com/azproduction/lmd

Demo: http://jsfiddle.net/SKNHH/1/