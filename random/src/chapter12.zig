const std = @import("std");
pub fn main() !void {
    try currentWorkingDirectory();
}

fn readAndWrite() !void {
    var stdin_buffer: [1024]u8 = undefined;
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    var stdin_reader = std.fs.File.stdin().reader(&stdin_buffer);
    const stdin = &stdin_reader.interface;
    const stdout = &stdout_writer.interface;

    try stdout.writeAll("Type your name\n");
    try stdout.flush();

    const name = try stdin.takeDelimiterExclusive('\n');

    try stdout.print("Your name is: {s}\n", .{name});
    try stdout.flush();
}

fn currentWorkingDirectory() !void {
    const cwd = std.fs.cwd();
    const file = try cwd.createFile("foo.txt", .{});
    // Don't forget to close the file at the end.
    defer file.close();
    // Do things with the file ...

    var file_buffer: [1024]u8 = undefined;
    var fw = file.writer(&file_buffer);
    const fww = &fw.interface;
    _ = try fww.writeAll("Writing this line to the file\n");
    try fww.flush();
}
