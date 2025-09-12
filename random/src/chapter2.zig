const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    loopDeferTest();
}

pub fn funnyIf(x: u8) void {
    std.debug.print("x ", .{});
    if (x > 10) {
        std.debug.print("> ", .{});
    } else {
        std.debug.print("<= ", .{});
    }
    std.debug.print("10!\n", .{});
}

pub fn switchTest() void {
    const Job = enum { DA, SDE, HR, MK };
    const role = Job.SDE;
    const area: []const u8 = switch (role) {
        .DA, .SDE => "Engineer",
        .HR, .MK => "Other",
    };

    std.debug.print("{any}\n", .{@TypeOf(role)});
    std.debug.print("Role : {any}, {s}", .{ role, area });
}

pub fn weirdLoop() void {
    var n: u8 = 1;

    // Can't do this looks like
    // loop_block: {
    //     if (n == 10) {
    //         break :loop_block;
    //     }
    //     print("{d}", .{n});
    //     n += 1;
    //     continue :loop_block;
    // }

    loop_switch: switch (n) {
        0...9 => {
            n += 1;
            print("{d} \n", .{n});
            continue :loop_switch n;
        },
        else => {
            break :loop_switch;
        }
    }
}

pub fn loopDeferTest() void {
    var i: u8 = 1;

    // the defer will fire every time that the loop runs
    // in this case it will run 4 times,
    while (i < 5) : (i += 1) {
        defer print("exit loop ", .{});
    }
}
