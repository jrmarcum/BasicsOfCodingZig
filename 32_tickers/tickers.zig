// Tickers fire repeatedly at regular intervals. Zig has no built-in ticker;
// this example uses a loop with std.time.sleep and std.time.nanoTimestamp.

const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // Tick 3 times at 500ms intervals (matching Go's 1600ms window).
    for (0..3) |_| {
        std.time.sleep(500 * std.time.ns_per_ms);
        const t = std.time.nanoTimestamp();
        try stdout.print("Tick at {d}\n", .{t});
    }

    try stdout.print("Ticker stopped\n", .{});
}
