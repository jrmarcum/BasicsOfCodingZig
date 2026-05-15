Send SIGINT (Ctrl-C) or SIGTERM to trigger the handler; uses sigaction on Unix and SetConsoleCtrlHandler on Windows.

___

##### Run Command:
`zig run signals.zig`

##### Results:
`awaiting signal`
`interrupt`
`exiting`
