const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;
const Str = []const u8;

var gpa_impl = std.heap.GeneralPurposeAllocator(.{}){};
pub const gpa = &gpa_impl.allocator;

// Add utility functions here
pub fn parseFileString(allocator: *std.mem.Allocator, fileContents : []const u8) !void {
    var numbers = std.ArrayList(u8).init(allocator);

    for (fileContents) |character| {
        if (character == '\n') {
            var stringAsNumber = try std.fmt.parseInt(u64, numbers.items, 10);

            std.debug.print("Hello, {any}!\n", .{stringAsNumber});
            numbers.shrinkRetainingCapacity(0);
            //numbers = std.ArrayList(u8).init(allocator);
        } else if (character == '\r') {
            continue;
        } else {
            try numbers.append(character);
        }
    }
}

// Useful stdlib functions
const tokenize = std.mem.tokenize;
const split = std.mem.split;
const indexOf = std.mem.indexOfScalar;
const indexOfAny = std.mem.indexOfAny;
const indexOfStr = std.mem.indexOfPosLinear;
const lastIndexOf = std.mem.lastIndexOfScalar;
const lastIndexOfAny = std.mem.lastIndexOfAny;
const lastIndexOfStr = std.mem.lastIndexOfLinear;
const trim = std.mem.trim;
const sliceMin = std.mem.min;
const sliceMax = std.mem.max;

const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;

const min = std.math.min;
const min3 = std.math.min3;
const max = std.math.max;
const max3 = std.math.max3;

const print = std.debug.print;
const assert = std.debug.assert;

const sort = std.sort.sort;
const asc = std.sort.asc;
const desc = std.sort.desc;
