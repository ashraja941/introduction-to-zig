const std = @import("std");

fn arrayOperations() void {
    std.debug.print("Array Operations\n", .{});

    const a = [_]u8{ 1, 2, 3 };
    const b = [_]u8{ 4, 5 };
    std.debug.print("a : {any}\nb : {any}\n", .{ a, b });

    const c = a ++ b;
    std.debug.print("c : {any}\n", .{c});

    const d = c ++ c;
    std.debug.print("d : {any}\n", .{d});
}

fn breakToPoint() void {
    var y: i32 = 123;
    const x = add_one: {
        y += 1;
        break :add_one y;
    };
    if (x == 124 and y == 124) {
        std.debug.print("Hey!", .{});
    }
}

pub fn main() !void {
    // arrayOperations();
    breakToPoint();
}
