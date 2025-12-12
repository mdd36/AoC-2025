//
//  Day07.swift
//  AdventOfCode-2025
//
//  Created by Matthew Dickson on 12/11/25.
//

class Day07 : Solution {
  struct Coord : Hashable, Equatable {
    let row: Int
    let col: Int
    
    init(_ row: Int, _ col: Int) {
      self.row = row
      self.col = col
    }
  }
  func part1(input: String) -> String {
    let grid = input.split(separator: "\n")
      .compactMap { $0.trim() }
      .map { $0.split(separator: "") }
    let start = Coord(0, grid[0].firstIndex(of: "S")!)
    var splits = 0
    var seen = Set<Coord>()
    var stack: [Coord] = [start]
   
    while let c = stack.popLast() {
      if seen.contains(c) || c.row >= grid.count || c.col < 0 || c.col >= grid[0].count {
        continue
      }
      seen.insert(c)
      if grid[c.row][c.col] == "^" {
        splits += 1
        stack.append(.init(c.row + 1, c.col + 1))
        stack.append(.init(c.row + 1, c.col - 1))
      } else {
        stack.append(.init(c.row + 1, c.col))
      }
    }
    
    return "\(splits)"
  }
  
  func part2(input: String) -> String {
    let grid = input.split(separator: "\n")
      .compactMap { $0.trim() }
      .map { $0.split(separator: "") }
    let start = Coord(0, grid[0].firstIndex(of: "S")!)
    return "\(dfs(from: start, on: grid))"
  }
  
  var cache: [Coord:Int] = [:]
  func dfs(from coord: Coord, on grid: [[Substring]]) -> Int {
    let row = coord.row
    let col = coord.col
    
    if row >= grid.count {
      return 1
    }
    
    if col < 0 || col >= grid[0].count {
      return 0
    }
    
    if let cached = cache[coord] {
      return cached
    }
    
    if grid[row][col] == "^" {
      cache[coord] = dfs(from: .init(row+1, col+1), on: grid)
      + dfs(from: .init(row+1, col-1), on: grid)
    } else {
      cache[coord] = dfs(from: .init(row+1, col), on: grid)
    }
    
    return cache[coord]!
  }
}
