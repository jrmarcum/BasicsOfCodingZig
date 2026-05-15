Zig has no stdlib URL parser; std.mem string helpers are used instead.

___

##### Run Command:
`zig run url-parsing.zig`

##### Results:
`postgres`
`user:pass`
`user`
`pass`
`host.com:5432`
`host.com`
`5432`
`/path`
`f`
`k=v`
`map[k:[v]]`
`v`
