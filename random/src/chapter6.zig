const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    optionals();
}

pub fn pointerType() void {
    const a: u8 = 1;
    var b: u8 = 2;

    // can use either a constant or a variable.
    const pointer1: *const u8 = &a;
    // can't use a constant to a pointer of type *T, will need to be a variable
    const pointer2: *u8 = &b;

    var pointer3: *const u8 = &a;
    var pointer4: *u8 = &b;

    pointer3 = &b;
    pointer4 = &b;

    print("{any},{any},{any},{any}", .{ pointer1.*, pointer2.*, pointer3.*, pointer4.* });
}

fn optionals() void {
    var a: ?u8 = 1;
    var b: u8 = 3;
    a = null;

    const p1: *?u8 = &a;
    var p2: ?*u8 = &b;

    p2 = null;
    _ = p1;
    print("{any}", .{a});
    print("{any}", .{p2.?});
}
