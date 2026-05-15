const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const stdout = std.io.getStdOut().writer();

    // Start an HTTP server on port 8090
    const address = try std.net.Address.parseIp("0.0.0.0", 8090);
    var server = try address.listen(.{ .reuse_address = true });
    defer server.deinit();

    try stdout.print("Listening on http://localhost:8090\n", .{});

    // Accept connections in a loop
    while (true) {
        const connection = try server.accept();
        // Handle the connection in a new thread
        const thread = try std.Thread.spawn(.{}, handleConnection, .{ allocator, connection });
        thread.detach();
    }
}

fn handleConnection(allocator: std.mem.Allocator, connection: std.net.Server.Connection) void {
    defer connection.stream.close();

    var read_buffer: [8192]u8 = undefined;
    var http_server = std.http.Server.init(connection, &read_buffer);

    var request = http_server.receiveHead() catch return;

    const path = request.head.target;

    if (std.mem.eql(u8, path, "/hello")) {
        // Simple hello handler
        request.respond("hello\n", .{}) catch return;
    } else if (std.mem.eql(u8, path, "/headers")) {
        // Echo request headers back in the response body
        var body = std.ArrayList(u8).init(allocator);
        defer body.deinit();

        var it = request.iterateHeaders();
        while (it.next()) |header| {
            body.writer().print("{s}: {s}\n", .{ header.name, header.value }) catch return;
        }

        request.respond(body.items, .{}) catch return;
    } else {
        request.respond("404 Not Found\n", .{ .status = .not_found }) catch return;
    }
}
