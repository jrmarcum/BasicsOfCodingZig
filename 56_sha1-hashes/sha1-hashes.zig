const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const s = "sha1 this string";

    var h = std.crypto.hash.Sha1.init(.{});
    h.update(s);
    var digest: [std.crypto.hash.Sha1.digest_length]u8 = undefined;
    h.final(&digest);

    try stdout.print("{s}\n", .{s});
    try stdout.print("{s}\n", .{std.fmt.fmtSliceHexLower(&digest)});
}
