On Unix, replaces the current process with ls -a -l -h using execve. On Windows, spawns cmd /c dir as a subprocess since exec-replace is not supported.

___

##### Run Command:
`zig run execing-processes.zig`

##### Results:
`total 16`
`drwxr-xr-x  4 mark 136B Oct 3 16:29 .`
`drwxr-xr-x 91 mark 3.0K Oct 3 12:50 ..`
`-rw-r--r--  1 mark 1.3K Oct 3 16:28 execing-processes.zig`
