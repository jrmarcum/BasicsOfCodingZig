const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    // Read lines from stdin and print them uppercased
    while (true) {
        const line = stdin.readUntilDelimiterAlloc(allocator, '\n', 1024 * 1024) catch |err| switch (err) {
            error.EndOfStream => break,
            else => return err,
        };
        defer allocator.free(line);

        // Trim Windows-style \r if present
        const trimmed = std.mem.trimRight(u8, line, "\r");

        // Uppercase the line
        const upper = try allocator.alloc(u8, trimmed.len);
        defer allocator.free(upper);
        for (trimmed, 0..) |c, i| {
            upper[i] = std.ascii.toUpper(c);
        }

        try stdout.print("{s}\n", .{upper});
    }
}
