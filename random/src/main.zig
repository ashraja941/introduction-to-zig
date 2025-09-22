const std = @import("std");
const c1 = @import("chapter1.zig");
const c2 = @import("chapter2.zig");
const c3 = @import("chapter3.zig");
//chapter 4 was project
//chapter 5 was debugging (didn't install debugger)
const c6 = @import("chapter6.zig");

pub const std_options = @import("logger.zig").options;

pub fn main() !void {
    std.log.info("Running...", .{});

    // try c1.nonEnglish();
    // c2.main();
    // try c3.main();

    c6.main();

    std.log.info("Finished Execution...", .{});
}
