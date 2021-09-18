const input = @embedFile("../../Inputs/day01.txt");

const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;
const HashMap = std.AutoHashMap;

const TARGET = @as(usize, 2020);

const ParseIterator = struct {
    const Self = @This();

    split: mem.SplitIterator,

    pub fn init(string: []const u8) Self {
        return Self{ .split = mem.split(string, "\r\n") };
    }

    pub fn next(self: *Self) ?anyerror!usize {
        return if (self.split.next()) |line| fmt.parseInt(usize, line, 10) else null;
    }
};

const Answer = struct { p1: usize, p2: usize };

fn solve(iter: ParseIterator, target: usize, allocator: *mem.Allocator) !Answer {
    var p1: ?usize = null;
    var p2: ?usize = null;

    var set = HashMap(usize, void).init(allocator);
    defer set.deinit();

    var iterator = iter;
    while (iterator.next()) |item| {
        const x = try item;

        const search_value_p1 = target -% x;

        if (set.get(search_value_p1)) |_| {
            if (p1 == null) p1 = x * search_value_p1;
        }

        var keyiter = set.keyIterator();
        while (keyiter.next()) |y| {
            const search_value_p2 = target -% x -% y.*;
            if (set.get(search_value_p2)) |_| {
                if (p2 == null) p2 = x * y.* * search_value_p2;
            }
        }

        try set.put(x, {});
    }

    return Answer{ .p1 = p1.?, .p2 = p2.? };
}

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true, .enable_memory_limit = true }){};
    const allocator = &gpa.allocator;
    defer {
        const bytesUsed = gpa.total_requested_bytes;
        const info = gpa.deinit();
        std.log.info("\n\t[*] Leaked: {}\n\t[*] Bytes leaked: {}", .{ info, bytesUsed });
    }

    const parseiter = ParseIterator.init(input);
    const answer = try solve(parseiter, TARGET, allocator);

    std.debug.print("Part 1: {}\nPart2: {}\n", .{ answer.p1, answer.p2 });
}
