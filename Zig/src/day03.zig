const input = @embedFile("../../Inputs/day03.txt");
const std = @import("std");
const mem = std.mem;

pub fn traverse(map: []const u8, config: struct { right: usize, down: usize }) usize {
    var lines = mem.split(input, "\r\n");
    var trees = @as(usize, 0);

    var x = @as(usize, 0);

    while (lines.next()) |line| {
        var skip = config.down - 1;
        while (skip != 0) : ({
            skip -= 1;
        }) {
            _ = lines.next();
        }

        const vx = x % line.len;
        if (line[vx] == '#') {
            trees += 1;
        }

        x += config.right;
    }

    return trees;
}

pub fn part1(map: []const u8) usize {
    return traverse(map, .{ .right = 3, .down = 1 });
}

pub fn part2(map: []const u8) usize {
    const configs = .{
        .{ .right = 1, .down = 1 },
        .{ .right = 3, .down = 1 },
        .{ .right = 5, .down = 1 },
        .{ .right = 7, .down = 1 },
        .{ .right = 1, .down = 2 },
    };

    var trees = @as(usize, 1);
    inline for (configs) |config| {
        trees *= traverse(input, config);
    }

    return trees;
}

pub fn main() anyerror!void {
    const p1 = part1(input);
    const p2 = part2(input);

    std.debug.print("Part 1: {}\nPart 2: {}", .{ p1, p2 });
}
