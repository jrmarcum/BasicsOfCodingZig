# Basics of Coding Zig

## Project Overview

This project is one language implementation within a **multi-language comparative study** of
programming syntax, lines of code required, and compile/run performance. The same set of 78
example programs is implemented in Zig, Go, C, Rust, V, and other languages so that the languages
can be compared side-by-side.

Lessons are translated from **[Basics of Coding Go](https://github.com/jrmarcum/BasicsOfCodingGo)**
by Jon Marcum, which is itself adapted from **[Go by Example](https://github.com/mmcgrana/gobyexample)**
by Mark McGranaghan.

## Project Structure

```text
BasicsOfCodingZig/
├── CLAUDE.md          — canonical project context for AI-assisted development
├── LICENSE            — CC0 (Jon Marcum's original contributions)
├── NOTICE             — attribution for CC BY 3.0 derived content
├── README.md          — this file
├── upstream/          — reference copy of BasicsOfCodingGo lessons
│   └── basicsofcodinggo/
└── ##_topic-name/     — 78 lessons, 01_hello-world through 78_sha256-hashes
    ├── topic-name.zig — runnable Zig source
    └── topic-name.md  — lesson explanation with run command and expected output
```

> **AI-assisted development:** `CLAUDE.md` in the project root contains full context for
> Claude sessions — toolchain, lesson notes, Zig translation decisions, and conventions.
> All project context is kept in that file so sessions are fully portable.

## Preface

What this text is and what it is not: This text is intended to introduce the reader to the basics of the Zig programming language in the sense that they will be able to write minimal types of programs and run the code. It is not intended to go into advanced topics like advanced concurrency, complex pointer arithmetic, comptime metaprogramming, and other advanced software engineering topics.

The programs are intended to be run in the terminal as that is common to most operating systems. Linux and Mac come preinstalled with a terminal. Windows may or may not have it pre-installed. "Windows Terminal" can be installed from the Microsoft Store.

## Installation and Setup of Zig

To setup Zig for use, navigate to the [ziglang](https://github.com/ziglang/zig/wiki/Install-Zig-from-a-Package-Manager) website and locate an appropriate package manager for your operating system. Install and follow the directions on how to perform further settings for use. A package manager makes the install process much easier (brew for Mac, chocolatey for Windows, and varies based on linux distribution). If Zig has been installed properly you will be able to type the following command in the terminal command line and receive the response shown:

```text
$ zig version
0.13.0
(Note: the version shown here varies with your installed version)
```

All examples in this project run with a single command:

```sh
$ zig run filename.zig
```

A few lessons require additional flags:

- **C interop** (any lesson linking libc): `zig run -lc filename.zig`
- **Windows network** (lessons 69–72): `zig run -lws2_32 filename.zig`
- **Command-line args** (lessons 64–66): compile first, then pass args after `--`

## Comments

Comments are used to document what your code does so that others can understand it when reviewing your code.

```zig
// This is a single-line comment
```

Zig does not have block comments. Doc comments use `///` (on declarations) or `//!` (at the top of a file or container).

## Keywords

|            |            |            |             |             |
|:----------:|:----------:|:----------:|:-----------:|:-----------:|
| addrspace  | align      | allowzero  | and         | anyframe    |
| anytype    | asm        | async      | await        | break       |
| callconv   | catch      | comptime   | const       | continue    |
| defer      | else       | enum       | errdefer    | error       |
| export     | extern     | fn         | for         | if          |
| inline     | linksection| noalias    | noinline    | nosuspend   |
| opaque     | or         | orelse     | packed      | pub         |
| resume     | return     | struct     | suspend     | switch      |
| test       | threadlocal| try        | union       | unreachable |
| usingnamespace | var    | volatile   | while       |             |

## Data Types

> ### 1. Integer Types
>> #### a. **i8, i16, i32, i64, i128**: signed integers (2⁷ − 1 through 2¹²⁷ − 1)
>> #### b. **u8, u16, u32, u64, u128**: unsigned integers (0 through 2¹²⁸ − 1)
>> #### c. **isize**: signed pointer-sized integer (i32 or i64 depending on architecture)
>> #### d. **usize**: unsigned pointer-sized integer (u32 or u64 depending on architecture)
>> #### e. **comptime_int**: arbitrary-precision integer, compile-time only
>> #### f. **iN / uN**: arbitrary-width integers from i1/u1 up to i65535/u65535
> ### 2. Float Types
>> #### a. **f16**: 16-bit IEEE 754 half-precision float
>> #### b. **f32**: 32-bit IEEE 754 single-precision float
>> #### c. **f64**: 64-bit IEEE 754 double-precision float
>> #### d. **f80**: 80-bit extended-precision float
>> #### e. **f128**: 128-bit IEEE 754 quad-precision float
>> #### f. **comptime_float**: arbitrary-precision float, compile-time only
> ### 3. **bool**: true or false
> ### 4. **void**: zero-bit type; functions with no return value return void
> ### 5. **type**: the type of types; used in comptime generics
> ### 6. **anyerror**: the global error set; a superset of all error sets
> ### 7. **noreturn**: the type of expressions that never return (break, return, unreachable, @panic)
> ### 8. Pointer Types
>> #### a. **\*T**: single-item pointer
>> #### b. **[*]T**: many-item pointer (unknown length)
>> #### c. **[]T**: slice (fat pointer: pointer + length)
>> #### d. **\*[N]T**: pointer to an array of known length N
> ### 9. Optional and Error Types
>> #### a. **?T**: optional — either a value of type T or null
>> #### b. **!T**: error union — either an error or a value of type T
>> #### c. **anyerror!T**: error union with the global error set

## Operators

> ### Arithmetic Operators
> |         |                                                 |
> |:-------:|:------------------------------------------------|
> | **+**   | add one number to another                       |
> | **-**   | subtract one number from another                |
> | **\***  | multiply one number by another                  |
> | **/**   | divide one number by another                    |
> | **%**   | remainder of dividing one number by another     |
> | **+%**  | wrapping add (modular arithmetic)               |
> | **-%**  | wrapping subtract                               |
> | **\*%** | wrapping multiply                               |
> ### Comparison Operators
> |         |                                                          |
> |:-------:|:---------------------------------------------------------|
> | **==**  | check if a value is equal to another                     |
> | **!=**  | check if a value is not equal to another                 |
> | **>**   | check if a value is greater than another                 |
> | **<**   | check if a value is less than another                    |
> | **>=**  | check if a value is greater than or equal to another     |
> | **<=**  | check if a value is less than or equal to another        |
> ### Logical Operators
> |         |                                                  |
> |:-------:|:-------------------------------------------------|
> | **and** | returns true if both operands are true           |
> | **or**  | returns true if either operand is true           |
> | **!**   | negates a boolean value                          |
> ### Assignment Operators
> |          |                                                              |
> |:--------:|:-------------------------------------------------------------|
> | **=**    | assign a value to a variable                                 |
> | **+=**   | add a number to the existing value and assign the result     |
> | **-=**   | subtract a number and assign the result                      |
> | **\*=**  | multiply the existing value and assign the result            |
> | **/=**   | divide the existing value and assign the result              |
> | **%=**   | take the remainder and assign the result                     |

## Statements

A statement is an instruction that a program can execute.

> ### Conditional Statements
> | **if**        | performs a block if a condition is met                                             |
> | **if-else**   | performs one block if a condition is met, otherwise performs the else block        |
> | **switch**    | selects one of many code blocks to execute based on an expression                  |
> ### Iterative Statements
> | **for**       | iterates over arrays, slices, or integer ranges                           |
> | **while**     | loop that continues while a condition is true                             |
> | **while-else**| executes the else branch when the while condition becomes false           |
> ### Transfer Statements
> | **break**     | terminates the enclosing loop or block; can return a value from a block   |
> | **continue**  | skips to the next iteration of a loop                                     |
> | **return**    | returns a value from a function                                           |
> | **defer**     | defers execution of a statement until the end of the enclosing scope      |
> | **errdefer**  | defers execution only if the scope exits with an error                    |
> | **try**       | returns the error from an error union, or unwraps the value               |
> | **catch**     | handles the error branch of an error union                                |
> | **orelse**    | provides a fallback value or block when an optional is null               |
> | **unreachable**| marks a code path as unreachable; causes safety-checked undefined behavior |

## Functions

> ### 1. **main**: entry point of every Zig program — `pub fn main() !void`
> ### 2. **std.debug.print**: formatted output to stderr (common in examples)
> ### 3. **std.io.getStdOut().writer()**: writer for stdout
> ### 4. **std.fmt.allocPrint / std.fmt.bufPrint**: format strings into buffers
> ### 5. **@panic**: terminates the program with an error message

## File Input and Output

> ### 1. File Input
>> #### a. `std.fs.cwd().openFile` — open a file relative to the current working directory
>> #### b. `file.reader().readAllAlloc` — read entire file into an allocated buffer
>> #### c. `file.reader().readUntilDelimiterAlloc` — read line by line
> ### 2. File Output
>> #### a. `std.fs.cwd().createFile` — create or truncate a file
>> #### b. `file.writer().print` / `file.writer().writeAll` — write formatted or raw bytes
>> #### c. `file.close()` / `defer file.close()` — close file handle

## Attribution

This project is adapted in part from **[Basics of Coding Go](https://github.com/jrmarcum/BasicsOfCodingGo)**
by [Jon Marcum](https://github.com/jrmarcum), licensed under the
[Creative Commons Attribution 3.0 Unported License](http://creativecommons.org/licenses/by/3.0/).

Basics of Coding Go was itself adapted in part from **[Go by Example](https://github.com/mmcgrana/gobyexample)**
by [Mark McGranaghan](https://github.com/mmcgrana), also licensed under the
[Creative Commons Attribution 3.0 Unported License](http://creativecommons.org/licenses/by/3.0/).

Attribution for all derived lesson content is centralized in this README and in the NOTICE file.
This project exists as a platform for multi-language comparative study of syntax, language
simplicity, lines of code required, and compile/run performance.

## License

This repository contains two tiers of content:

| Content | License |
| --- | --- |
| Lesson files and code examples adapted from *Basics of Coding Go* (derived from *Go by Example*) | [CC BY 3.0](http://creativecommons.org/licenses/by/3.0/) — see NOTICE |
| Original contributions by Jon Marcum (project structure, README, CLAUDE.md, comparative study additions) | [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/) — see LICENSE |

The root `LICENSE` file (CC0) applies to Jon Marcum's original contributions only.
The `NOTICE` file clarifies that CC BY 3.0 governs all content adapted from *Basics of Coding Go*
and *Go by Example*.
