Zig has no subcommand stdlib; dispatch is implemented manually. Must be compiled before running.

___

##### Run Command:
`zig build-exe command-line-subcommands.zig && ./command-line-subcommands foo -enable -name=joe a1 a2`

##### Results:
`subcommand 'foo'`
`  enable: true`
`  name: joe`
`  tail: [a1 a2]`
