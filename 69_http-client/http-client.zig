const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const stdout = std.io.getStdOut().writer();

    // Create an HTTP client
    var client = std.http.Client{ .allocator = allocator };
    defer client.deinit();

    // Issue a GET request to gobyexample.com
    const uri = try std.Uri.parse("https://gobyexample.com");

    var server_header_buffer: [16 * 1024]u8 = undefined;
    var req = try client.open(.GET, uri, .{
        .server_header_buffer = &server_header_buffer,
    });
    defer req.deinit();

    try req.send();
    try req.finish();
    try req.wait();

    // Print the HTTP response status
    try stdout.print("Response status: {}\n", .{req.response.status});

    // Print the first 5 lines of the response body
    var buf_reader = std.io.bufferedReader(req.reader());
    var line_buf: [4096]u8 = undefined;
    var i: usize = 0;
    while (i < 5) : (i += 1) {
        const line = buf_reader.reader().readUntilDelimiterOrEof(&line_buf, '\n') catch break orelse break;
        const trimmed = std.mem.trimRight(u8, line, "\r");
        try stdout.print("{s}\n", .{trimmed});
    }
}
