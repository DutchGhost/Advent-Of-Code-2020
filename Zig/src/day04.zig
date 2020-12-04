const input = @embedFile("../../Inputs/day04.txt"); 
const std = @import("std");
const mem = std.mem;
const json = std.json;

const Password = struct {
    // birth year
    byr: usize,

    // issue year
    iyr: usize,

    // expiration year
    eyr: usize,

    // height
    hgt: usize,
    
    // hair color
    hcl: []const u8,

    // eye color 
    ecl: []const u8,
    
    // passport id
    pid: usize,

    // country id
    cid: usize,
};

pub fn main() anyerror!void {
    var lines = mem.split(input, "\r\n\r\n");
    
    var valids = @as(usize, 0);
    while(lines.next()) |line| {
        var isOk = true; 

        inline for (std.meta.fields(Password)) |field| {
            isOk = isOk and (mem.indexOf(u8, line, field.name) != null or mem.eql(u8, field.name, "cid"));
        }
        
        if (isOk) { valids += 1;}
    }

    std.debug.print("{}", .{valids});
}
