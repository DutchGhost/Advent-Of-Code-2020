const input = @embedFile("../../Inputs/day05.txt");
const std = @import("std");
const mem = std.mem;

const Set = enum { LOWER, UPPER, NONE };

const Range = struct { lower: u32, upper: u32, last_set: Set = Set.NONE };

pub fn main() anyerror!void {
    var lines = mem.split(input, "\r\n");
    var max_seat_id = @as(u32, 0);

    while (lines.next()) |line| {
        const row_line = line[0..7];
        var column_line = line[7..line.len];

        var row: Range = Range{ .lower = 0, .upper = 127 };
        var columns = Range{ .lower = 0, .upper = 7 };

        for (row_line) |c| {
            const middle = (row.upper + row.lower) / 2;
            switch (c) {
                'F' => {
                    row.upper = middle;
                    row.last_set = Set.UPPER;
                },
                'B' => {
                    row.lower = middle + 1;
                    row.last_set = Set.LOWER;
                },
                else => unreachable,
            }
        }

        for (column_line) |c| {
            const middle = (columns.upper + columns.lower) / 2 + 1;

            switch (c) {
                'L' => {
                    columns.upper = middle;
                    columns.last_set = Set.UPPER;
                },
                'R' => {
                    columns.lower = middle;
                    columns.last_set = Set.LOWER;
                },
                else => unreachable,
            }

        }

        const final_row = switch (row.last_set) {
            Set.NONE => unreachable,
            Set.UPPER => row.lower,
            Set.LOWER => row.upper,
        };

        const final_column = switch (columns.last_set) {
            Set.NONE => unreachable,
            Set.UPPER => columns.lower,
            Set.LOWER => columns.upper,
        };


        const seat_id = final_row * 8 + final_column;
        if (seat_id > max_seat_id) max_seat_id = seat_id;
    }

    std.debug.print("SEAT ID = {}\n", .{max_seat_id});
}
