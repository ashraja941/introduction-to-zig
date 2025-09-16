const std = @import("std");
const c1 = @import("chapter1.zig");
const c2 = @import("chapter2.zig");
const c3 = @import("chapter3.zig");

pub const std_options = @import("logger.zig").options;

pub fn main() !void {
    std.log.info("Running...", .{});

    // try c1.nonEnglish();
    // c2.main();
    try c3.main();

    std.log.info("Finished Execution...", .{});
}
