const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    try arenaAllocatorTest();
}

pub fn initateArray() void {
    var buffer: [10]u8 = undefined;
    for (0..buffer.len) |i| {
        buffer[i] = 0;
    }
    print("{any}", .{buffer});

    const buffer2: [10]u8 = [1]u8{0} ** 10;
    print("{any}", .{buffer2});
}
pub fn arenaAllocatorTest() !void {
    // arena allocator needs some overhead to make sure that it tracks
    var buffer: [100]u8 = undefined;
    for (0..buffer.len) |i| {
        buffer[i] = 0;
    }

    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    var aa = std.heap.ArenaAllocator.init(fba.allocator());
    const allocator = aa.allocator();
    defer aa.deinit();

    const input = try allocator.alloc(u8, 2);
    // defer allocator.free(input);

    const input2 = try allocator.alloc(u8, 2);
    // defer allocator.free(input2);

    print("{any}", .{input});
    print("{any}", .{input2});
}
pub fn stackFixedBuffer() !void {
    var buffer: [10]u8 = undefined;
    for (0..buffer.len) |i| {
        buffer[i] = 0;
    }

    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();
    const input = try allocator.alloc(u8, 5);
    defer allocator.free(input);

    const input2 = try allocator.alloc(u8, 5);
    defer allocator.free(input2);

    // const input3 = try allocator.alloc(u8, 5);
    // defer allocator.free(input3);

    print("{any}", .{input});
    // print("{any}", .{input2});
    // print("{any}", .{input3});
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
