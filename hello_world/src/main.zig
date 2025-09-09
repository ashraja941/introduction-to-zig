const std = @import("std");

pub fn main() !void {
    var bw = std.io.bufferedWriter(std.io.getStdOut().writer());
    const out = bw.writer();

    try out.print("Hello, {s}\n", .{"world"});
    try bw.flush(); // don't forget to flush
}
