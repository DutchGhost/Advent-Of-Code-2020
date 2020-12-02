const input = @embedFile("../../Inputs/day02.txt");
const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;

const Password = struct {
    begin: usize,
    end: usize,
    letter: u8,
    str: []const u8,

    fn nappearance(password: Password) bool {
        var count = @as(usize, 0);

        for (password.str) |c| {
            if (c == password.letter) {
                count += 1;
            }
        }

        return (password.begin <= count and count <= password.end);
    }

    fn positionAppearance(password: Password) bool {
        var a = password.str[password.begin - 1] == password.letter;
        var b = password.str[password.end - 1] == password.letter;

        return !(a == b);
    }
};

pub fn main() anyerror!void {
    var lines = mem.split(input, "\r\n");

    var validsPart1 = @as(usize, 0);
    var validsPart2 = @as(usize, 0);

    while (lines.next()) |line| {
        var split = mem.split(line, " ");

        var range = split.next().?;
        var letter = split.next().?[0];
        var str = split.next().?;

        split = mem.split(range, "-");
        var begin = try fmt.parseInt(u32, split.next().?, 10);
        var end = try fmt.parseInt(u32, split.next().?, 10);

        var password = Password{ .begin = begin, .end = end, .letter = letter, .str = str };
        if (password.nappearance()) {
            validsPart1 += 1;
        }

        if (password.positionAppearance()) {
            validsPart2 += 1;
        }
    }

    std.debug.print("p1 = {}\np2 = {}", .{ validsPart1, validsPart2 });
}
