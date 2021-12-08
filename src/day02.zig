const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;
const Str = []const u8;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("../data/day02.txt");

pub fn main() !void {
      var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    var allocator = &arena.allocator;

    const actionList = try util.parseDay02FileString(allocator, data);

    const part1Answer = doPart1(actionList.items);
    std.debug.print("Part 1 answer  = {any}\n", .{part1Answer});

    const part2Answer = doPart2(actionList.items);
    std.debug.print("Part 2 answer  = {any}\n", .{part2Answer});
}

fn doPart1(actions : []util.MoveAction) u64 {
    var depth : u64 = 0;
    var distance : u64 = 0;

    var i : usize = 0;
    while (i < actions.len) : (i += 1) {
        const currentAction = actions[i];
        switch (currentAction.direction) {
            util.Direction.Forward => distance += currentAction.length,
            util.Direction.Down => depth += currentAction.length,
            util.Direction.Up => depth -= currentAction.length,
        }
    }

    std.debug.print("Function Depth  = {any}\n", .{depth});
    std.debug.print("Function Distance  = {any}\n", .{distance});

    return depth * distance;
}

fn doPart2(actions : []util.MoveAction) u64 {
    var depth : u64 = 0;
    var distance : u64 = 0;
    var aim : u64 = 0;

    var i : usize = 0;
    while (i < actions.len) : (i += 1) {
        const currentAction = actions[i];
        switch (currentAction.direction) {
            util.Direction.Forward => {
                distance += currentAction.length;
                depth += aim * currentAction.length;
            },
            util.Direction.Down => aim += currentAction.length,
            util.Direction.Up => aim -= currentAction.length,
        }
    }

    std.debug.print("Function Depth  = {any}\n", .{depth});
    std.debug.print("Function Distance  = {any}\n", .{distance});

    return depth * distance;
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
