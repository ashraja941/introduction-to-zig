const std = @import("std");
const Thread = std.Thread;
const Pool = std.Thread.Pool;
const Mutex = std.Thread.Mutex;
const RwLock = std.Thread.RwLock;

const shouldRun = std.atomic.Value(bool).init(true);

var counter: u64 = 0;

pub fn main() !void {
    try readWriteLocks();
}

fn reader(lock: *RwLock) !void {
    while (true) {
        lock.lockShared();
        const v: u64 = counter;
        std.debug.print("Read value : {d}\n", .{v});
        lock.unlockShared();
        Thread.sleep(2 * std.time.ns_per_s);
    }
}

fn writer(lock: *RwLock) !void {
    while (true) {
        lock.lock();
        counter += 1;
        lock.unlock();
        Thread.sleep(1 * std.time.ns_per_s);
    }
}

fn readWriteLocks() !void {
    var lock: RwLock = .{};

    const rt1 = try Thread.spawn(.{}, reader, .{&lock});
    const rt2 = try Thread.spawn(.{}, reader, .{&lock});
    const rt3 = try Thread.spawn(.{}, reader, .{&lock});

    const wt = try Thread.spawn(.{}, writer, .{&lock});

    rt1.join();
    rt2.join();
    rt3.join();
    wt.join();
}

fn mutexTest() !void {
    var mutex: Mutex = .{};

    const t1 = try Thread.spawn(.{}, increment, .{&mutex});
    const t2 = try Thread.spawn(.{}, increment, .{&mutex});

    t1.join();
    t2.join();

    std.debug.print("Final Value : {d}", .{counter});
}

fn threadPools() !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const opt = Pool.Options{
        .n_jobs = 5,
        .allocator = allocator,
    };

    var pool: Pool = undefined;
    try pool.init(opt);
    defer pool.deinit();

    const id: u8 = 1;
    const id2: u8 = 2;

    try pool.spawn(printId, .{ stdout, &id });
    try pool.spawn(printId, .{ stdout, &id2 });
}

fn create1Thread() !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    const thread = try Thread.spawn(.{}, do_some_work, .{stdout});
    thread.join();
}

fn create2Threads() !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    const id: u8 = 1;
    var id2: u8 = 2;

    const thread1 = try Thread.spawn(.{}, printId, .{ stdout, &id });
    const thread2 = try Thread.spawn(.{}, printId, .{ stdout, &id2 });

    id2 = 3;

    _ = try stdout.write("Thread 1 joining \n");
    try stdout.flush();
    thread1.join();

    Thread.sleep(1000 * std.time.ns_per_ms);

    _ = try stdout.write("Thread 2 joining \n");
    try stdout.flush();
    thread2.join();
}

fn createDetached() !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    const id: u8 = 1;

    const thread1 = try Thread.spawn(.{}, printId, .{ stdout, &id });
    thread1.detach();

    _ = try stdout.write("Exiting");
    try stdout.flush();

    Thread.sleep(100 * std.time.ns_per_ms);
}

fn printId(stdout: *std.Io.Writer, id: *const u8) void {
    _ = stdout.print("ID : {d}\n", .{id.*}) catch void;
    stdout.flush() catch {};
}

fn do_some_work(stdout: *std.Io.Writer) !void {
    _ = try stdout.write("Starting the work.\n");
    try stdout.flush();
    Thread.sleep(1000 * std.time.ns_per_ms);
    _ = try stdout.write("Finishing the work.\n");
    try stdout.flush();
}

fn increment(mutex: *Mutex) void {
    for (0..100000) |_| {
        mutex.lock();
        counter += 1;
        mutex.unlock();
    }
}
