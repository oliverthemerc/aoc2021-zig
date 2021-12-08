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
pub fn parseDay01FileString(allocator: *std.mem.Allocator, fileContents : []const u8) !std.ArrayList(u64) {
    var numberStringBuilder = std.ArrayList(u8).init(allocator);
    var parsedNumbers = std.ArrayList(u64).init(allocator);

    for (fileContents) |character| {
        if (character == '\n') {
            var stringAsNumber = try std.fmt.parseInt(u64, numberStringBuilder.items, 10);

            try parsedNumbers.append(stringAsNumber);
            numberStringBuilder.shrinkRetainingCapacity(0);
        } else if (character == '\r') {
            continue;
        } else {
            try numberStringBuilder.append(character);
        }
    }

    return parsedNumbers;
}

pub fn parseDay02FileString(allocator: *std.mem.Allocator, fileContents : []const u8) !std.ArrayList([]const u8) {
    var lineStringBuilder = std.ArrayList(u8).init(allocator);
    var allLines = std.ArrayList([]const u8).init(allocator);

    for (fileContents) |character| {
        if (character == '\n') {
           // var stringAsNumber = try std.fmt.parseInt(u64, numberStringBuilder.items, 10);

            std.debug.print("Found line  = {s}\n", .{lineStringBuilder.items});
            const copiedLine = lineStringBuilder.items[0..lineStringBuilder.items.len];
            std.debug.print("Found copied line  = {s}\n", .{copiedLine});

            try allLines.append(copiedLine);

            // try parsedNumbers.append(stringAsNumber);
            lineStringBuilder.shrinkRetainingCapacity(0);
        } else if (character == '\r') {
            continue;
        } else {
            try lineStringBuilder.append(character);
        }
    }

    return allLines;
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
