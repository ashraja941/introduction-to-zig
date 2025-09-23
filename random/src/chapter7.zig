const std = @import("std");
const expect = std.testing.expect;
const print = std.debug.print;
const Allocator = std.mem.Allocator;
const expectError = std.testing.expectError;

fn MemoryLeak(allocator: Allocator) !void {
    const buffer = try allocator.alloc(u32, 10);
    defer allocator.free(buffer);
    // _ = buffer;
}

fn AllocError(allocator: Allocator) !void {
    const buffer = try allocator.alloc(u8, 100);
    defer allocator.free(buffer);

    buffer[0] = 2;
}
test "strings are equal?" {
    const str1 = "Hello, world!";
    const str2 = "Hello, world!";
    try std.testing.expectEqualStrings(str1, str2);
}
test "values are equal?" {
    const a = [_]u8{ 0, 1, 2 };
    const b = [_]u8{ 0, 1, 2 };
    try std.testing.expectEqualSlices(u8, &a, &b);
}

test "addition test" {
    const a: u8 = 10;
    const b: u8 = 10;
    try expect((a + b) == 20);
}

test "Memory Leak" {
    const allocator = std.testing.allocator;
    try MemoryLeak(allocator);
}

test "Out of Memory Error" {
    var buffer: [10]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    try expectError(error.OutOfMemory, AllocError(allocator));
}
