const std = @import("std");
const c1 = @import("chapter1.zig");
const c2 = @import("chapter2.zig");
const c3 = @import("chapter3.zig");

pub fn main() !void {
    // try c1.nonEnglish();
    // c2.main();
    try c3.main();
}
