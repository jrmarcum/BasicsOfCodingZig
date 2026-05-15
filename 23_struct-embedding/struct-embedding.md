Zig uses named field composition instead of struct embedding; fields are accessed via `co.base.num` rather than `co.num`.

___

##### Run Command:
`zig run struct-embedding.zig`

##### Results:
`co={num: 1, str: some name}`
`also num: 1`
`describe: base with num=1`
`describer: base with num=1`
