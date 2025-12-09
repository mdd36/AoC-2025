//
//  Day03.swift
//  AdventOfCode-2025
//
//  Created by Matthew Dickson on 12/8/25.
//
import Darwin

class Day03 : Solution {
  
  func part1(input: String) -> String {
    let bankSum = parse(input: input)
      .map { bank in maxJolts(in: bank) }
      .sum()
    return "\(bankSum)"
  }
  
  func part2(input: String) -> String {
    let bankSum = parse(input: input)
      .map { bank in maxJolts(in: bank, cells: 12) }
      .sum()
    return "\(bankSum)"
  }
  
  func maxJolts(in bank: [Int]) -> Int {
    var tens: Int? = nil
    var ones: Int? = nil
    var maxJolts = 0
    
    for cell in bank {
      if tens == nil {
        tens = cell
      } else if ones == nil {
        ones = cell
      } else if let o = ones, o < cell {
        ones = cell
      }
      
      if let tens, let ones {
        maxJolts = max(maxJolts, 10 * tens + ones)
      }
      
      if let t = tens, let o = ones, t < o {
        tens = o
        ones = nil
      }
    }
    
    return maxJolts
  }
  
  func maxJolts(in bank: [Int], cells: Int) -> Int {
    var chosenCells: [Int] = []
    var maxJolts = 0
    
    for cell in bank {
      if chosenCells.count < cells {
        chosenCells.append(cell)
      }
      
      if chosenCells.count < cells {
        continue
      }
      
      if chosenCells[cells - 1] < cell {
        chosenCells[cells - 1] = cell
      }
      
      let jolts: Int = chosenCells
        .enumerated()
        .reduce(0) { acc, val in
          return acc + Int(pow(10.0, Double(cells - val.offset - 1))) * val.element
        }
      maxJolts = max(maxJolts, jolts)
      
      for i in 0..<cells-1 {
        if chosenCells[i] < chosenCells[i+1] {
          for j in i..<cells-1 {
            chosenCells[j] = chosenCells[j+1]
          }
          _ = chosenCells.popLast()
          break
        }
      }
    }
    
    return maxJolts
  }
  
  func parse(input: String) -> [[Int]] {
    return input.split(separator: "\n")
      .compactMap { line in line.trim() }
      .map { (line: String) in line.map { $0.wholeNumberValue! } }
  }
}
