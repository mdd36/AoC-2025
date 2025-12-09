//
//  Day04.swift
//  AdventOfCode-2025
//
//  Created by Matthew Dickson on 12/8/25.
//

class Day04 : Solution {
  
  enum Contents {
    case empty
    case paper(neighbors: Int)
    
    func accessible() -> Bool {
      return switch self {
      case .empty:
        false
      case .paper(let neighbors):
        neighbors < 4
      }
    }
  }
  
  func part1(input: String) -> String {
    let movableCount = parse(input)
      .map { row in row.count(where: { cell in cell.accessible() } ) }
      .sum()
    
    return "\(movableCount)"
  }
  
  func part2(input: String) -> String {
    var grid = parse(input)
    var nextGrid = grid // Arrays have value semantics
    var removed = 0
    var removedInIteration = 0
    
    repeat {
      removedInIteration = 0
      grid = nextGrid
      for (r, row) in grid.enumerated() {
        for (c, cell) in row.enumerated() {
          if cell.accessible() {
            removed += 1
            removedInIteration += 1
            nextGrid[r][c] = .empty
            decrementNeighbors(from: &nextGrid, row: r, col: c)
          }
        }
      }
      
    } while removedInIteration > 0
    
    return "\(removed)"
  }
  
  func parse(_ input: String) -> [[Contents]] {
    let lines = input
      .split(separator: "\n")
      .compactMap { line in line.trim() }
    
    let grid = lines.map { line in line.map { ch in ch == "@" } }
    var res: [[Contents]] = []
    
    for (i, row) in grid.enumerated() {
      var inProgress: [Contents] = []
      for (j, hasPaper) in row.enumerated() {
        guard hasPaper else {
          inProgress.append(.empty)
          continue
        }
        var neighbors = 0
        for vOffset in -1...1 {
          for hOffset in -1...1 {
            if hOffset == 0 && vOffset == 0 {
              continue
            }
            
            let r = i + vOffset
            let c = j + hOffset
            if r < 0 || c < 0 || r >= grid.count || c >= row.count {
              continue
            }
            
            if grid[r][c] {
              neighbors += 1
            }
          }
        }
        inProgress.append(.paper(neighbors: neighbors))
      }
      res.append(inProgress)
    }
    
    return res
  }

  func decrementNeighbors(from grid: inout [[Contents]], row: Int, col: Int) {
    for vOffset in -1...1 {
      for hOffset in -1...1 {
        if hOffset == 0 && vOffset == 0 {
          continue
        }
        
        let r = row + vOffset
        let c = col + hOffset
        if r < 0 || c < 0 || r >= grid.count || c >= grid[0].count {
          continue
        }
        
        if case .paper(let neighbors) = grid[r][c] {
          grid[r][c] = .paper(neighbors: neighbors - 1)
        }
      }
    }
  }
}
