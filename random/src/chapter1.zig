const std = @import("std");

pub fn typeOfString() void {
    // using sentinal terminated strings
    std.debug.print("{any}\n", .{@TypeOf("A literal value")});

    // using slices
    const str: []const u8 = "A string value";
    std.debug.print("{any}\n", .{@TypeOf(str)});
}

pub fn arrayOperations() void {
    std.debug.print("Array Operations\n", .{});

    const a = [_]u8{ 1, 2, 3 };
    const b = [_]u8{ 4, 5 };
    std.debug.print("a : {any}\nb : {any}\n", .{ a, b });

    const c = a ++ b;
    std.debug.print("c : {any}\n", .{c});

    const d = c ++ c;
    std.debug.print("d : {any}\n", .{d});
}

pub fn breakToPoint() void {
    var y: i32 = 123;
    const x = add_one: {
        y += 1;
        break :add_one y;
    };
    if (x == 124 and y == 124) {
        std.debug.print("Hey!", .{});
    }
}
