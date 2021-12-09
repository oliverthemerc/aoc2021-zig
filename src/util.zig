const std = @import("std");
const mem = @import("std").mem;
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;
const Str = []const u8;

var gpa_impl = std.heap.GeneralPurposeAllocator(.{}){};
pub const gpa = &gpa_impl.allocator;

pub const ReadType = enum {
    ArrayList,
    Slice,
};

pub const ReadFileError = error{
    TypeNotImplemented,
} ;

// Add utility functions here
pub fn parseDay01FileString(allocator: *std.mem.Allocator, readType : ReadType, fileContents : []const u8) ![]u64 {
    if (readType == ReadType.ArrayList) {
        return parseDay01FileArrayList(allocator, fileContents);    
    }

    return ReadFileError.TypeNotImplemented;
}

fn parseDay01FileArrayList(allocator: *std.mem.Allocator, fileContents : []const u8) ![]u64 {
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

    return parsedNumbers.items;
}

pub const Direction = enum {
    Forward,
    Up,
    Down,
};

pub const MoveAction = struct {
    direction : Direction,
    length : u64,
};

pub fn parseDay02FileString(allocator: *std.mem.Allocator,  readType : ReadType, fileContents : []const u8) ![]MoveAction {
    if (readType != ReadType.ArrayList) {
        return ReadFileError.TypeNotImplemented;
    }

    var lines = try readLinesFromFile(allocator, fileContents);
    var actions = std.ArrayList(MoveAction).init(allocator);

    var directionStringBuilder = std.ArrayList(u8).init(allocator);
    var lengthStringBuilder = std.ArrayList(u8).init(allocator);

    for (lines.items) |line| {
        var foundSplit = false;

        //split and collect parts of line
        for (line) |character| {
            if (character == ' ') {
                foundSplit = true;
            } else {
                if (foundSplit) {
                    try lengthStringBuilder.append(character);
                } else {
                    try directionStringBuilder.append(character);
                }
            }
        }


        //turn action into enum
        const foundDirection = switch (directionStringBuilder.items[0]) {
            102 => Direction.Forward,
            117 => Direction.Up,
            100 => Direction.Down,
            else => unreachable,
        };

        //turn numerals into number
        var lengthAsNumber = try std.fmt.parseInt(u64, lengthStringBuilder.items, 10);

        try actions.append(MoveAction{
            .direction = foundDirection,
            .length = lengthAsNumber,
        });

        directionStringBuilder.shrinkRetainingCapacity(0);
        lengthStringBuilder.shrinkRetainingCapacity(0);
    }

    lines.clearAndFree();
    directionStringBuilder.clearAndFree();
    lengthStringBuilder.clearAndFree();

    return actions.items;
}

pub fn readLinesFromFile(allocator: *std.mem.Allocator, fileContents : []const u8) !std.ArrayList([]const u8) {
    var lineStringBuilder = std.ArrayList(u8).init(allocator);
    var allLines = std.ArrayList([]const u8).init(allocator);

    for (fileContents) |character| {
        if (character == '\n') {
            var copiedLine = try allocator.alloc(u8, lineStringBuilder.items.len);
            std.mem.copy(u8, copiedLine[0..copiedLine.len], lineStringBuilder.items[0..lineStringBuilder.items.len]);
            try allLines.append(copiedLine);

            lineStringBuilder.shrinkRetainingCapacity(0);
        } else if (character == '\r') {
            continue;
        } else {
            try lineStringBuilder.append(character);
        }
    }

    lineStringBuilder.clearAndFree();

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
