const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    try createString();
}

pub fn createString() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const name = "Ash";
    const output = try std.fmt.allocPrint(allocator, "Hello {s}!!!", .{name});
    print("{s}\n", .{output});
}

pub fn pointerToDeletedSpace() void {
    const temp: *const u8 = add(25, 5);
    const r: *const u8 = add(25, 4);
    _ = r;
    print("{any}", .{temp.*});
}
pub fn add(a: u8, b: u8) *const u8 {
    var ans = a + b;
    return &ans;
}
