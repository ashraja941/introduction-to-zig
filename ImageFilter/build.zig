const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.addModule("ImageFilter", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
    });

    const exe = b.addExecutable(.{
        .name = "ImageFilter",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "ImageFilter", .module = mod },
            },
        }),
    });

    exe.linkLibC();

    exe.addCSourceFile(.{
        .file = b.path("vendor/miniz/miniz.c"),
        .flags = &.{"-std=c99"},
    });
    exe.addIncludePath(b.path("vendor/miniz"));

    exe.addCSourceFile(.{
        .file = b.path("vendor/libspng/spng.c"),
        .flags = &.{
            "-DSPNG_STATIC",
            "-DSPNG_USE_MINIZ",
            "-std=c99",
        },
    });
    exe.addIncludePath(b.path("vendor/libspng"));

    b.installArtifact(exe);

    const run_step = b.step("run", "Run the app");

    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const mod_tests = b.addTest(.{
        .root_module = mod,
    });

    const run_mod_tests = b.addRunArtifact(mod_tests);

    const exe_tests = b.addTest(.{
        .root_module = exe.root_module,
    });
    exe_tests.linkLibC();

    const run_exe_tests = b.addRunArtifact(exe_tests);

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_mod_tests.step);
    test_step.dependOn(&run_exe_tests.step);
}
