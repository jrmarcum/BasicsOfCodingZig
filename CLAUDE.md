# BasicsOfCoding[LANGUAGE] — Session Context

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

### JAVA

**Toolchain:** JDK 17+
```
$ java filename.java                          # single-file (Java 11+)
$ javac filename.java && java ClassName       # multi-file
```

**Key translations:**
| Go | Java |
|---|---|
| `fmt.Println` | `System.out.println` |
| `fmt.Printf` | `System.out.printf` |
| Slices | `ArrayList<T>` |
| Maps | `LinkedHashMap<K,V>` (preserves insertion order) |
| Multiple return | `record` / custom class |
| Closures | Lambda `Function<T,R>` |
| `interface` | `interface` |
| `defer` | `try-finally` / `try-with-resources` |
| goroutines | `Thread` / `ExecutorService` |
| channels | `LinkedBlockingQueue<T>` |
| `select` | `CompletableFuture.anyOf` |
| `sync.WaitGroup` | `CountDownLatch` |
| `sync.Mutex` | `ReentrantLock` / `synchronized` |
| `sync/atomic` | `AtomicLong` |
| `error` | `Exception` |
| `panic/recover` | `throw` / `try-catch` |
| `regexp` | `java.util.regex.Pattern` + `Matcher` |
| `net/http` client | `java.net.http.HttpClient` |
| SHA1/SHA256 | `MessageDigest.getInstance("SHA-256")` |
| Base64 | `java.util.Base64` |

**Notes:** Use `LinkedHashMap` for maps (insertion-order output). Use
`str.codePoints()` for Unicode iteration (lesson 22). Lesson 34 atomic:
`AtomicLong` with `getAndAdd`.

**.gitignore:** `*.class`, `*.jar`, `target/`, `build/`, `.gradle/`, `tmp/`

---

### JULIA

**Toolchain:**
```
$ julia filename.jl
```

**Key translations:**
| Go | Julia |
|---|---|
| `fmt.Println` | `println()` |
| `fmt.Printf` | `@printf` / `"$(expr)"` interpolation |
| Slices | `Vector{T}` **(1-indexed!)** |
| Maps | `Dict{K,V}()` |
| Multiple return | `return a, b` / `a, b = func()` |
| Closures | `x -> x * 2` |
| Interfaces | Abstract types + multiple dispatch |
| `defer` | `try-finally` |
| goroutines | `Threads.@spawn` |
| channels | `Channel{T}(capacity)` |
| `sync.WaitGroup` | `fetch(task)` per spawned task |
| `sync.Mutex` | `ReentrantLock()` |
| `sync/atomic` | `Threads.Atomic{T}()` + `atomic_add!` |
| `error` | `error("msg")` / `try-catch` |
| `regexp` | `r"pattern"` / `match` / `eachmatch` |
| `net/http` | `HTTP.jl` package |
| SHA1/SHA256 | `SHA.sha256` (SHA.jl stdlib) |
| Base64 | `base64encode` (Base64 stdlib) |

**Notes:** Arrays are 1-indexed — adjust all indexing. Use `OrderedDict`
(DataStructures.jl) for maps where output order must match upstream.
`JULIA_NUM_THREADS` must be > 1 for concurrency lessons; note in `.md`.

**.gitignore:** `Manifest.toml`, `*.ji`, `.julia/`, `tmp/`

---

### KOTLIN

**Toolchain:**
```
$ kotlinc filename.kt -include-runtime -d out.jar && java -jar out.jar
```

**Key translations:**
| Go | Kotlin |
|---|---|
| `fmt.Println` | `println()` |
| `fmt.Printf` | `"${...}"` string templates |
| Slices | `MutableList<T>` / `mutableListOf()` |
| Maps | `LinkedHashMap<K,V>()` |
| Multiple return | `Pair<A,B>` / data class |
| Closures | `{ x -> x * 2 }` lambda |
| `interface` | `interface` |
| `defer` | `use { }` / `try-finally` |
| goroutines | `launch { }` (kotlinx.coroutines) |
| channels | `Channel<T>` (kotlinx.coroutines) |
| `select` | `select { }` expression |
| `sync.WaitGroup` | `Job.join()` / `coroutineScope { }` |
| `sync.Mutex` | `Mutex()` (kotlinx.coroutines) |
| `sync/atomic` | `AtomicLong` |
| `error` | `Exception` / sealed `Result<T>` |
| `regexp` | `Regex("pattern")` / `findAll` |
| SHA1/SHA256 | `MessageDigest.getInstance("SHA-256")` |
| Base64 | `java.util.Base64` |

**Notes:** `LinkedHashMap` for insertion-order map output. kotlinx.coroutines
required for lessons 27–37. Use `str.codePoints()` for Unicode in lesson 22.

**.gitignore:** `*.class`, `*.jar`, `build/`, `.gradle/`, `out/`, `tmp/`

---

### PYTHON

**Toolchain:** Python 3.10+
```
$ python filename.py
```

**Key translations:**
| Go | Python |
|---|---|
| `fmt.Println` | `print()` |
| `fmt.Printf` | `print(f"...")` |
| Slices | `list` |
| Maps | `dict` (insertion-order since 3.7) |
| Multiple return | `return a, b` / `a, b = func()` |
| Closures | `lambda x: x*2` / nested `def` |
| Interfaces | `typing.Protocol` / `ABC` |
| `defer` | `with` / `contextlib` |
| goroutines | `threading.Thread` |
| channels | `queue.Queue` |
| `select` | `selectors` / polling |
| `sync.WaitGroup` | `Thread.join()` |
| `sync.Mutex` | `threading.Lock()` |
| `sync/atomic` | `threading.Lock()` + `int` counter |
| `error` | `Exception` / `raise` |
| `panic/recover` | `raise` / `try-except` |
| `regexp` | `re` module |
| `net/http` client | `urllib.request` / `requests` |
| SHA1/SHA256 | `hashlib.sha256()` |
| Base64 | `base64.b64encode()` |

**Notes:** `dict` preserves insertion order — map output matches upstream
naturally. No built-in atomic int; use `Lock` + counter (note in lesson 34).
Use `threading` (not `asyncio`) for concurrency lessons to match Go's
thread-based model semantically.

**.gitignore:** `__pycache__/`, `*.pyc`, `.venv/`, `venv/`, `tmp/`

---

### C# (target: .NET 8)

**Toolchain:** .NET SDK 8+
```
$ dotnet run       # from within the lesson project directory
```

Each lesson is a minimal SDK-style console project:
```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
  </PropertyGroup>
</Project>
```

**Key translations:**
| Go | C# |
|---|---|
| `fmt.Println` | `Console.WriteLine()` |
| `fmt.Printf` | `Console.Write($"...")` |
| Slices | `List<T>` / `T[]` |
| Maps | `Dictionary<K,V>` |
| Multiple return | `(T1, T2)` tuple / `out` / `record` |
| Closures | `x => x * 2` / `Func<T,R>` |
| `interface` | `interface` |
| `defer` | `using` / `IDisposable` / `try-finally` |
| goroutines | `Task` / `async-await` |
| channels | `Channel<T>` (System.Threading.Channels) |
| `select` | `Task.WhenAny` |
| `sync.WaitGroup` | `CountdownEvent` / `Task.WhenAll` |
| `sync.Mutex` | `lock` / `SemaphoreSlim` |
| `sync/atomic` | `Interlocked.Add` |
| `error` | `Exception` |
| `panic/recover` | `throw` / `try-catch` |
| `regexp` | `Regex` (System.Text.RegularExpressions) |
| `net/http` client | `HttpClient` |
| SHA1/SHA256 | `SHA256.HashData(bytes)` |
| Base64 | `Convert.ToBase64String` |

**Notes:** `Dictionary<K,V>` iteration order is not guaranteed; document
any output differences for map lessons. `using var` is the idiomatic `defer`
for `IDisposable` (lesson 43). `ImplicitUsings` is enabled — no need to
explicitly `using System.Collections.Generic` etc.

**.gitignore:** `bin/`, `obj/`, `.vs/`, `*.user`, `tmp/`

---

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