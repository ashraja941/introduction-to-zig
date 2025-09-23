const std = @import("std");
const SocketConf = @import("config.zig");
const Request = @import("request.zig");
const Method = Request.Method;
const Response = @import("response.zig");

const std_options = @import("logging.zig").options;

pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();
    std.log.info("Starting the Server", .{});

    const socket = try SocketConf.Socket.init();
    std.log.debug("Socket address : {any}", .{socket._address});

    var server = try socket._address.listen(.{});
    const connection = try server.accept();

    var buffer: [1000]u8 = [1]u8{0} ** 1000;
    try Request.read_request(connection, buffer[0..]);

    const request = Request.parse_request(buffer[0..]);

    if (request.method == Method.GET) {
        if (std.mem.eql(u8, request.uri, "/")) {
            try Response.send_200(connection);
        } else {
            try Response.send_404(connection);
        }
    }
    std.log.info("Closing the server", .{});

    try stdout.print("Buffer Information : {any}\n", .{request});
    try bw.flush();
}
