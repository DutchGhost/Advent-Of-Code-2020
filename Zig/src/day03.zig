const input = @embedFile("../../Inputs/day03.txt");
const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;

pub fn main() anyerror!void {
    var lines = mem.split(input, "\r\n");
    
    var trees = @as(usize, 0);

    var x = @as(usize, 0);
    while(lines.next()) |line| {
        const vx = x % line.len;
        if (line[vx] == '#') {
            trees += 1;
        }
        x += 3;
    }

    std.debug.print("{}", .{trees});
}
