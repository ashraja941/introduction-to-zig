const std = @import("std");
const c1 = @import("chapter1.zig");
const c2 = @import("chapter2.zig");
const c3 = @import("chapter3.zig");
//chapter 4 was project
//chapter 5 was debugging (didn't install debugger)
const c6 = @import("chapter6.zig");
// chapter 7 was project
const c8 = @import("chapter8.zig");
// chapter 9 was build process things
const c10 = @import("chapter10.zig");
const c11 = @import("chapter11.zig");
// chapter 12 was the stack project
const c13 = @import("chapter13.zig");
// chapter 14 is interoperability with C (did it in the project)
// chapter 15 is Project 4
const c16 = @import("chapter16.zig");

pub const std_options = @import("logger.zig").options;

pub fn main() !void {
    std.log.info("Running...", .{});

    // try c1.nonEnglish();
    // c2.main();
    // try c3.main();

    // c6.main();
    // try c10.main();
    // try c11.main();
    // try c12.main();

    try c16.main();

    std.log.info("Finished Execution...", .{});
}
