const std = @import("std");
pub fn typeCheckString() void {
    const simple_array = [_]i32{ 1, 2, 3, 4 };
    const string_obj: []const u8 = "A string object";
    std.debug.print("Type 1: {}\n", .{@TypeOf(simple_array)});
    std.debug.print("Type 2: {}\n", .{@TypeOf("A string literal")});
    std.debug.print("Type 3: {}\n", .{@TypeOf(&simple_array)});
    std.debug.print("Type 4: {}\n", .{@TypeOf(string_obj)});
}

pub fn nonEnglish() !void {
    var utf8 = try std.unicode.Utf8View.init("アメリカȺ");
    var iterator = utf8.iterator();

    while (iterator.nextCodepointSlice()) |codePoint| {
        std.debug.print("got {x}\n", .{codePoint});
    }
}

pub fn iterateString() void {
    const string_object = ";asldkfjȺ";
    std.debug.print("Bytes that represents the string object: ", .{});
    for (string_object) |byte| {
        std.debug.print("{X} ", .{byte});
    }
    std.debug.print("\n", .{});
}

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
