const input = @embedFile("../../Inputs/day05.txt");
const std = @import("std");
const mem = std.mem;

pub fn partition(characters: []const u8) u8 {
    const len = characters.len;
    var place = @as(u8, 0);

    for (characters) |c, idx| switch (c) {
        'B', 'R' => place |= @as(u8, 1) << @intCast(u3, len - idx - 1),
        'F', 'L' => {},
        else => unreachable,
    };

    return place;
}

pub fn main() anyerror!void {
    var lines = mem.split(input, "\r\n");
    var max_seat_id = @as(u32, 0);
    var boarded: [1000]bool = [1]bool{false} ** 1000;

    while (lines.next()) |line| {
        const row_line = line[0..7];
        var column_line = line[7..line.len];

        const row = @intCast(u32, partition(row_line));
        const column = @intCast(u32, partition(column_line));
        const seat_id = row * 8 + column;

        if (seat_id > max_seat_id) max_seat_id = seat_id;

        boarded[seat_id] = true;
    }

    var prv = @as(usize, 0);
    const boarding_id = for (boarded) |b, idx| {
        if (!b) {
            defer prv = idx;
            if (idx == prv + 1 or idx == 0) continue else break idx;
        }
    } else 0;

    std.debug.print("Part 1: {}\nPart 2: {}", .{ max_seat_id, boarding_id });
}
