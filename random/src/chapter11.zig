const std = @import("std");

pub fn main() !void {
    try appendToArrayList();
}

const Person = struct {
    name: []const u8,
    age: u8,
    height: f32,
};

fn MultiArrayStructure() !void {
    const personArray = std.MultiArrayList(Person);

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var people = personArray{};
    defer people.deinit(allocator);

    try people.append(allocator, .{ .name = "Ash", .age = 24, .height = 10 });
    try people.append(allocator, .{ .name = "a;sldjf", .age = 24, .height = 10 });
    try people.append(allocator, .{ .name = "Test", .age = 24, .height = 10 });

    var slice = people.slice();

    for (slice.items(.age), slice.items(.name)) |*a, *n| {
        std.debug.print("name : {s}, age : {d}\n", .{ n.*, a.* });
    }
}

const NodeU32 = struct { data: u32, node: std.SinglyLinkedList.Node = .{} };
const DoubleNodeU32 = struct { data: u32, node: std.DoublyLinkedList.Node = .{} };

fn DoublyLinkedListInit() !void {
    var ll: std.DoublyLinkedList = .{};

    var one: DoubleNodeU32 = .{ .data = 1 };
    var two: DoubleNodeU32 = .{ .data = 2 };
    // var three: DoubleNodeU32 = .{ .data = 3 };
    var five: DoubleNodeU32 = .{ .data = 5 };

    ll.append(&two.node);
    ll.insertAfter(&two.node, &five.node);
    ll.prepend(&one.node);

    std.debug.print("Number of nodes in the linked list : {d}\n", .{ll.len()});
    _ = ll.popFirst().?;
    std.debug.print("Number of nodes in the linked list : {d}\n", .{ll.len()});
    ll.remove(&two.node);
    std.debug.print("Number of nodes in the linked list : {d}\n", .{ll.len()});

    var it = ll.first;
    while (it) |node| : (it = node.next) {
        const l: *DoubleNodeU32 = @fieldParentPtr("node", node);
        std.debug.print("val : {d}", .{l.data});
    }
}

fn SinglylinkedListInit() !void {
    var ll: std.SinglyLinkedList = .{};

    var one: NodeU32 = .{ .data = 1 };
    var two: NodeU32 = .{ .data = 2 };
    var three: NodeU32 = .{ .data = 3 };
    var five: NodeU32 = .{ .data = 5 };

    ll.prepend(&two.node);
    two.node.insertAfter(&five.node);
    two.node.insertAfter(&three.node);
    ll.prepend(&one.node);

    std.debug.print("Number of nodes in the linked list : {d}\n", .{ll.len()});
    _ = ll.popFirst().?;
    std.debug.print("Number of nodes in the linked list : {d}\n", .{ll.len()});
    ll.remove(&two.node);
    std.debug.print("Number of nodes in the linked list : {d}\n", .{ll.len()});
}

fn hashTableInit() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var hashTable = std.hash_map.AutoHashMap(u32, u16).init(allocator);
    defer hashTable.deinit();

    try hashTable.put(5050, 89);
    try hashTable.put(4000, 3801);
    try hashTable.put(30, 38013);

    std.debug.print("N of values stored: {d}\n", .{hashTable.count()});
    std.debug.print("Value at key 5050: {d}\n", .{hashTable.get(5050).?});

    if (hashTable.remove(30)) {
        std.debug.print("Value at key 57709 successfully removed!\n", .{});
    }
    std.debug.print("N of values stored: {d}\n", .{hashTable.count()});

    var it = hashTable.iterator();

    while (it.next()) |kv| {
        std.debug.print("key : {any} ", .{kv.key_ptr.*});
        std.debug.print("value : {any}\n", .{kv.value_ptr.*});
    }
}

fn appendToArrayList() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var buffer = try std.ArrayList(u8).initCapacity(allocator, 100);
    defer buffer.deinit();

    for (0..10) |i| {
        const num: u8 = @intCast(i);
        try buffer.append(num);
    }
    std.debug.print("{any}\n", .{buffer.items});
    _ = buffer.orderedRemove(3);
    _ = buffer.swapRemove(3);

    std.debug.print("{any}\n", .{buffer.items});
    std.debug.print("{any}\n", .{buffer.items.len});
}

fn insertToArrayList() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var buffer = try std.ArrayList(u8).initCapacity(allocator, 100);
    defer buffer.deinit();

    for (0..10) |i| {
        const num: u8 = @intCast(i);
        try buffer.append(num);
    }

    std.debug.print("{any}\n", .{buffer.items});
    _ = try buffer.insert(3, 40);
    _ = try buffer.insertSlice(3, &[_]u8{ 50, 50 });

    std.debug.print("{any}\n", .{buffer.items});
    std.debug.print("{any}\n", .{buffer.items.len});
}

fn startArrayList() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var buffer = try std.ArrayList(u8).initCapacity(allocator, 100);
    defer buffer.deinit();
}

test "deinit arraylist" {
    const allocator = std.testing.allocator;

    var buffer = try std.ArrayList(u8).initCapacity(allocator, 100);
    defer buffer.deinit();
}
