const std = @import("std");

const std_options = @import("logging.zig").options;

const stdout_file = std.io.getStdOut().writer();
var bw = std.io.bufferedWriter(stdout_file);
const stdout = bw.writer();

pub fn main() !void {
    std.log.debug("Starting the main function", .{});
}
