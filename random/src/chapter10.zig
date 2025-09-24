const std = @import("std");

const A = error{
    OutOfMemory,
    ConnectionTimeoutError,
};

pub fn main() !void {
    _ = handleReturnError();
}

fn handleReturnError() usize {
    const returnVal = returnError(false) catch 0;
    return returnVal;
}

fn returnError(val: bool) A!usize {
    if (val) return 1;
    return A.ConnectionTimeoutError;
}
