const std = @import("std");
const c1 = @import("chapter1.zig");

pub fn main() !void {
    try c1.nonEnglish();
}
