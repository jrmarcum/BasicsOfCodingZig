Zig uses std.json; map output order matches insertion order (StringArrayHashMap) rather than Go's sorted-key output.

___

##### Run Command:
`zig run json.zig`

##### Results:
`true`
`1`
`2.34`
`"vector"`
`["apple","peach","pear"]`
`{"apple":5,"lettuce":7}`
`{"Page":1,"Fruits":["apple","peach","pear"]}`
`{"page":1,"fruits":["apple","peach","pear"]}`
`map[num:6.13 strs:[a b]]`
`6.13`
`a`
`{1 [apple peach]}`
`apple`
`{"apple":5,"lettuce":7}`
