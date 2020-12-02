const input = @embedFile("../../Inputs/day01.txt");

const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;
const ArrayList = std.ArrayList;

const TARGET = @as(usize, 2020);

pub fn parseInput(slice: []const u8, allocator: *mem.Allocator) !ArrayList(usize) {
    var nums = ArrayList(usize).init(allocator);
    errdefer nums.deinit();

    var split = mem.split(slice, "\r\n");
    while (split.next()) |line| {
        const num = try fmt.parseInt(usize, line, 10);
        try nums.append(num);
    }

    return nums;
}

pub fn part1(slice: []const usize, target: usize) !usize {
    for (slice) |x, idx| {
        for (slice[idx..]) |y| {
            if (x + y == target) {
                return x * y;
            }
        }
    } else return error.SolutionNotFound;
}

pub fn part2(slice: []const usize, target: usize) !usize {
    for (slice) |x, idx| {
        for (slice[idx..]) |y, idx2| {
            for (slice[idx2..]) |z| {
                if (x + y + z == target) {
                    return x * y * z;
                }
            }
        }
    } else return error.SolutionNotFound;
}

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true, .enable_memory_limit = true }){};
    const allocator = &gpa.allocator;
    defer {
        const bytesUsed = gpa.total_requested_bytes;
        const info = gpa.deinit();
        std.log.info("\n\t[*] Leaked: {}\n\t[*] Bytes leaked: {}", .{ info, bytesUsed });
    }

    const numbers = try parseInput(input, allocator);
    defer numbers.deinit();

    const slice = numbers.items;

    const p1 = try part1(slice, TARGET);
    const p2 = try part2(slice, TARGET);

    std.debug.print("Part 1: {}\nPart 2: {}\n", .{ p1, p2 });
}
