# BasicsOfCodingZig — Session Context

## What This Project Is

A multi-language comparative study of programming syntax, simplicity, lines
of code, and performance. Each language implements the same 78 example
programs so they can be compared side-by-side.

The source of truth for program logic and expected output is **Basics of
Coding Go** by Jon Marcum (https://github.com/jrmarcum/BasicsOfCodingGo),
which lives as a git submodule at `upstream/basicsofcodinggo`. For every
lesson, read the upstream `.go` source and `.md` to understand what the
program does and what output it produces, then translate to idiomatic
[LANGUAGE].

The structural reference is **BasicsOfCodingC**
(https://github.com/jrmarcum/BasicsOfCodingC). Match its repo layout,
CLAUDE.md shape, NOTICE/LICENSE structure, and lesson `.md` format exactly.

## Project Structure

```
BasicsOfCoding[LANGUAGE]/
├── CLAUDE.md
├── LICENSE            — CC0 (Jon Marcum original contributions)
├── NOTICE             — CC BY 3.0 attribution for derived lesson content
├── README.md
├── upstream/
│   └── basicsofcodinggo/  — git submodule
└── ##_topic-name/
    ├── topic-name.[ext]
    └── topic-name.md
```

All 78 lessons: `01_hello-world` through `78_sha256-hashes`.
Numbers match BasicsOfCodingGo exactly — do not renumber.

## Lesson .md Format (exact, no deviations)

```
[Optional one-line description]

___

##### Run Command:
`[run command]`

##### Results:
`[output line 1]`
`[output line 2]`
```

No per-file attribution footers. Time-dependent or nondeterministic
lessons note this in the description line.

## Licensing Rule

Do NOT add per-file attribution footers. Attribution is handled centrally
in README and NOTICE. This is intentional and differs from some other repos.

## Output Matching

Match upstream Go output line-for-line. Where the language produces
structurally different output (e.g., map ordering, array formatting),
document the difference in the lesson `.md` description line.

## Special Lessons

- **58–60** (reading/writing files, line-filters): require a `tmp/`
  directory at runtime (gitignored, create manually). Lesson 58 also needs
  `tmp/dat.txt` containing `hello\n[lang]\n`.
- **50–52, 32, 37**: time-dependent output — note in `.md` that results vary.
- **27–37** (concurrency): nondeterministic per-thread ordering — note in `.md`.
- **64–66** (command-line args/flags/subcommands): must be compiled to a
  binary before running; args passed after `--` separator or equivalent.
- **68** (testing-and-benchmarking): use the language's native test framework.

---

## Language-Specific Reference

### ZIG

**Toolchain:** Zig 0.13+
```
$ zig run filename.zig
$ zig run -lc filename.zig        # when libc needed
```

**Key translations:**
| Go | Zig |
|---|---|
| `fmt.Println` | `std.debug.print("{s}\n", .{val})` |
| `fmt.Printf` | `stdout.print("{}\n", .{val})` |
| Slices | `[]T` / `std.ArrayList(T)` |
| Maps | `std.AutoHashMap(K, V)` |
| Multiple return | Error union `!T` / struct |
| Closures | Function pointer + context struct (no native closures) |
| Interfaces | Comptime duck typing / tagged union / vtable |
| `defer` | `defer` keyword **(native, exact equivalent)** |
| goroutines | `std.Thread.spawn` |
| channels | `std.Thread.Mutex` + condition variable (manual) |
| `select` | Manual polling (no built-in) |
| `sync.WaitGroup` | `thread.join()` after all spawns |
| `sync.Mutex` | `std.Thread.Mutex` |
| `sync/atomic` | `std.atomic.Value(T)` + `fetchAdd` |
| `error` | Error union `!T` + `try` / `catch` |
| `panic/recover` | `@panic` / no recovery |
| `regexp` | No stdlib; use `std.mem` helpers (document limitation) |
| `net/http` | Raw `std.net.tcp` + HTTP framing |
| SHA256 | `std.crypto.hash.sha2.Sha256` **(stdlib, no library needed)** |
| Base64 | `std.base64.standard` **(stdlib)** |

**Notes:** Zig `defer` runs at end of *scope*, not end of function — adjust
patterns accordingly. Always use an allocator (`std.heap.GeneralPurposeAllocator`)
and `defer allocator.deinit()`. Lesson 15 (closures) and 44 (collection-functions)
require struct-with-function-pointer pattern; document the difference in `.md`.
Lesson 47 (regexp): no stdlib regexp — use `std.mem.indexOf`/`startsWith` or
vendor a library; document this. Windows networking lessons need `-lws2_32`.

**.gitignore:** `zig-out/`, `.zig-cache/`, `tmp/`