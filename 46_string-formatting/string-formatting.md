Zig lacks Go's reflect-based %v/%+v/%#v/%T verbs; struct and type output is approximated. Pointer address will vary.

___

##### Run Command:
`zig run string-formatting.zig`

##### Results:
`{1 2}`
`{x:1 y:2}`
`main.point{x:1, y:2}`
`main.point`
`true`
`123`
`1110`
`!`
`1c8`
`78.900000`
`1.234000e+08`
`1.234000E+08`
`"string"`
`"\"string\""`
`6865782074686973`
`0xc000014080`
`|    12|   345|`
`|  1.20|  3.45|`
`|1.20  |3.45  |`
`|   foo|     b|`
`|foo   |b     |`
`a string`
