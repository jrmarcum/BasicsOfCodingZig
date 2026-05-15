On Windows, std.fs.path uses backslashes as the separator instead of forward slashes.

___

##### Run Command:
`zig run file-paths.zig`

##### Results:
`p: dir1/dir2/filename`
`dir1/filename`
`dir1/filename`
`Dir(p): dir1/dir2`
`Base(p): filename`
`false`
`true`
`.json`
`config`
`t/file`
`../c/t/file`
