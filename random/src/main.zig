const std = @import("std");
const c1 = @import("chapter1.zig");
const c2 = @import("chapter2.zig");

pub fn main() !void {
    // try c1.nonEnglish();
    c2.main();
}
