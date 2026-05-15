const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const stdout = std.io.getStdOut().writer();

    // Set an environment variable using OS-specific call
    const builtin = @import("builtin");
    if (builtin.os.tag == .windows) {
        _ = std.os.windows.kernel32.SetEnvironmentVariableW(
            std.unicode.utf8ToUtf16LeStringLiteral("FOO"),
            std.unicode.utf8ToUtf16LeStringLiteral("1"),
        );
    } else {
        _ = std.c.setenv("FOO", "1", 1);
    }

    // Get environment variables
    const foo = std.process.getEnvVarOwned(allocator, "FOO") catch try allocator.dupe(u8, "");
    defer allocator.free(foo);
    try stdout.print("FOO: {s}\n", .{foo});

    const bar = std.process.getEnvVarOwned(allocator, "BAR") catch try allocator.dupe(u8, "");
    defer allocator.free(bar);
    try stdout.print("BAR: {s}\n", .{bar});

    // List all environment variables (keys only)
    try stdout.print("\n", .{});
    var env_map = try std.process.getEnvMap(allocator);
    defer env_map.deinit();

    var env_it = env_map.iterator();
    while (env_it.next()) |entry| {
        try stdout.print("{s}\n", .{entry.key_ptr.*});
    }
}
