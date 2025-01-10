const std = @import("std");
const pw = @import("postwoman.zig");
/// Keep our main function small.
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const deinit_status = gpa.deinit();
        //fail test; can't try in defer as defer is executed after we return
        if (deinit_status == .leak) {
            std.log.err("memory leak", .{});
        }
    }
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    // Initialize our application
    var app = try pw.MyApp.init(arena.allocator());
    defer app.deinit();

    // Run the application
    try app.run();
}
