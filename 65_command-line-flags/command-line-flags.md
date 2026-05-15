Zig has no flag-parsing stdlib; arguments are parsed manually. Must be compiled before running.

___

##### Run Command:
`zig build-exe command-line-flags.zig && ./command-line-flags -word=opt -numb=7 -fork -svar=flag`

##### Results:
`word: opt`
`numb: 7`
`fork: true`
`svar: flag`
`tail: []`
