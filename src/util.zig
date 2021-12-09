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
    Library,
};

pub const ReadFileError = error{
    TypeNotImplemented,
    InvalidInput,
} ;

// Add utility functions here
pub fn parseDay01FileString(allocator: *std.mem.Allocator, readType : ReadType, fileContents : []const u8) ![]u64 {
    if (readType == ReadType.ArrayList) {
        return parseDay01FileArrayList(allocator, fileContents);    
    } else if (readType == ReadType.Slice) {
        return parseDay01FileSlice(allocator, fileContents);
    } else if  (readType == ReadType.Library) {
        return parseDay01FileLibrary(allocator, fileContents);
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

fn parseDay01FileSlice(allocator: *std.mem.Allocator, fileContents : []const u8) ![]u64 {
    var parsedNumbers = std.ArrayList(u64).init(allocator);

    var i : usize = 0;
    var lineStart: usize = 0;
    while (i < fileContents.len) : (i += 1) {
        if (fileContents[i] == '\n') {
            var stringAsNumber = try std.fmt.parseInt(u64, fileContents[lineStart..i-1], 10);

            try parsedNumbers.append(stringAsNumber);
            lineStart = i+1;
        }
    }

    return parsedNumbers.items;
}

fn parseDay01FileLibrary(allocator: *std.mem.Allocator, fileContents : []const u8) ![]u64 {
    var parsedNumbers = std.ArrayList(u64).init(allocator);

    var splitLines = split(u8, fileContents, "\r\n");

    while (true) {
        if (splitLines.next()) |line| {
            if (line.len == 0) {
                continue;
            }
            var stringAsNumber = try std.fmt.parseInt(u64, line, 10);
            try parsedNumbers.append(stringAsNumber);
        } else {
            break;
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
    var actions = try allocator.alloc(MoveAction, lines.len);

    var actionIndex : usize = 0;
    for (lines) |line| {
        const nullable_index = std.mem.indexOfScalar(u8, line, ' ');
        if (nullable_index) |index| {
            const foundDirection = switch (line[0]) {
                102 => Direction.Forward,
                117 => Direction.Up,
                100 => Direction.Down,
                else => unreachable,
            };

            var lengthAsNumber = try std.fmt.parseInt(u64, line[index+1..], 10);

            actions[actionIndex] = MoveAction{
                .direction = foundDirection,
                .length = lengthAsNumber,
            };
            actionIndex += 1;
        } else {
            return ReadFileError.InvalidInput;
        }
    }

    return actions;
}

pub fn readLinesFromFile(allocator: *std.mem.Allocator, fileContents : []const u8) ![][]const u8 {
    var allLines = std.ArrayList([]const u8).init(allocator);

    var splitLines = split(u8, fileContents, "\r\n");

    while (true) {
        if (splitLines.next()) |line| {
            if (line.len == 0) {
                continue;
            }
            try allLines.append(line);

        } else {
            break;
        }
    }

    return allLines.items;
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
