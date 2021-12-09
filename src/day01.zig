const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;
const Str = []const u8;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("../data/day01.txt");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    var allocator = &arena.allocator;

    var numberListFromArrayList = try util.parseDay01FileString(allocator, util.ReadType.ArrayList, data);
    var numberListFromSlice = try util.parseDay01FileString(allocator, util.ReadType.Slice, data);
    var numberListFromLibrary = try util.parseDay01FileString(allocator, util.ReadType.Library, data);
    std.debug.print("Slice Len  = {any}\n", .{numberListFromSlice.len});
    std.debug.print("Library Len  = {any}\n", .{numberListFromLibrary.len});


    var totalIncreasesFromList = countDepthIncreases(numberListFromArrayList);
    std.debug.print("Increases list  = {any}\n", .{totalIncreasesFromList});

    var totalIncreasesFromSlice = countDepthIncreases(numberListFromSlice);
    std.debug.print("Increases slice = {any}\n", .{totalIncreasesFromSlice});

    var totalIncreasesFromLibrary = countDepthIncreases(numberListFromLibrary);
    std.debug.print("Increases Library = {any}\n", .{totalIncreasesFromLibrary});

    std.debug.print("Increases are same {b}\n", .{totalIncreasesFromList==totalIncreasesFromSlice});
    std.debug.print("Increases are same {b}\n", .{totalIncreasesFromList==totalIncreasesFromLibrary});


    var totalSlidingIncreasesList = countSlidingDepthIncreases(numberListFromArrayList);
    std.debug.print("Sliding increases list = {any}\n", .{totalSlidingIncreasesList});

    var totalSlidingIncreasesSlice = countSlidingDepthIncreases(numberListFromSlice);
    std.debug.print("Sliding increases slice = {any}\n", .{totalSlidingIncreasesSlice});

    std.debug.print("Sliding increases are same {b}\n", .{totalSlidingIncreasesList==totalSlidingIncreasesSlice});
}

fn countDepthIncreases(depths: []u64) u64 {
    std.debug.print("Depths list count  = {any}\n", .{depths.len});

    var totalIncreases : u64 = 0;
    var i: usize = 1;
    while (i < depths.len) : (i += 1) {
        if (depths[i] > depths[i-1]) {
            totalIncreases += 1;
        }
    }

    return totalIncreases;
}

fn countSlidingDepthIncreases(depths: []u64) u64 {
    std.debug.print("Depths list count (sliding)  = {any}\n", .{depths.len});

    var totalIncreases : u64 = 0;
    var i: usize = 0;
    // +1 doing i and i+1 at the same time
    // +2 because the windows looks ahead 2 from the starting  index
    while (i < depths.len - (1 + 2)) : (i += 1) {
        if (calculateDepthWindowAt(depths, i + 1) > calculateDepthWindowAt(depths, i)) {
            totalIncreases += 1;
        }
    }

    return totalIncreases;
}

fn calculateDepthWindowAt(depths: []u64, startOfWindow : usize) u64 {
    return depths[startOfWindow] + depths[startOfWindow + 1] + depths[startOfWindow + 2];
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