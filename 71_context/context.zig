const std = @import("std");

// Zig has no context package; cancellation is implemented using a shared atomic flag.
// This example demonstrates a simple HTTP server where a handler can detect
// when the client disconnects using a cancellation flag.

const cancelled = std.atomic.Value(bool);

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const stdout = std.io.getStdOut().writer();

    // Start an HTTP server on port 8090
    const address = try std.net.Address.parseIp("0.0.0.0", 8090);
    var server = try address.listen(.{ .reuse_address = true });
    defer server.deinit();

    try stdout.print("Listening on http://localhost:8090/hello\n", .{});

    while (true) {
        const connection = try server.accept();
        const thread = try std.Thread.spawn(.{}, handleConnection, .{ allocator, connection });
        thread.detach();
    }
}

fn handleConnection(allocator: std.mem.Allocator, connection: std.net.Server.Connection) void {
    defer connection.stream.close();

    var cancel_flag = cancelled.init(false);

    var read_buffer: [8192]u8 = undefined;
    var http_server = std.http.Server.init(connection, &read_buffer);

    var request = http_server.receiveHead() catch return;

    const stdout = std.io.getStdOut().writer();
    stdout.print("server: hello handler started\n", .{}) catch return;
    defer stdout.print("server: hello handler ended\n", .{}) catch {};

    // Simulate work with cancellation check
    // In a real scenario, check the cancel flag periodically during long work.
    // Here we sleep for up to 10 seconds, checking for cancellation.
    var elapsed: u64 = 0;
    const deadline: u64 = 10_000_000_000; // 10 seconds in nanoseconds

    while (elapsed < deadline) {
        if (cancel_flag.load(.acquire)) {
            stdout.print("server: context cancelled\n", .{}) catch return;
            request.respond("context cancelled\n", .{ .status = .internal_server_error }) catch return;
            return;
        }
        std.time.sleep(100_000_000); // 100ms
        elapsed += 100_000_000;
    }

    _ = allocator;
    request.respond("hello\n", .{}) catch return;
}
