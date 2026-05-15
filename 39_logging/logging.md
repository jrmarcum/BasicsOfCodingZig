Log timestamps will vary; shown output is illustrative. Zig uses std.log (stderr) instead of Go's log package; structured JSON output is printed manually.

___

##### Run Command:
`zig run logging.zig`

##### Results:
`info: standard logger`
`info: with micro`
`info: with file/line`
`my:info: from mylog`
`ohmy:info: from mylog`
`from buflog:buf:info: hello`
`{"level":"INFO","msg":"hi there"}`
`{"level":"INFO","msg":"hello again","key":"val","age":25}`
