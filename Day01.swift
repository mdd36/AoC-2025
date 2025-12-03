//
//  Day01.swift
//  AdventOfCode-2025
//
//  Created by Matthew Dickson on 12/2/25.
//

class Day01 : Solution {
  enum Direction {
    case left, right
  }
  
  typealias DialMovement = (direction: Direction, amount: Int)
  
  func part1(input: String) -> String {
    var position = 50
    var timesAtZero = 0
    
    for line in input.split(separator: "\n") {
      if line == "" { continue }
      let (direction, amount) = read(action: line)
      if direction == .left {
        position -= amount
      } else {
        position += amount
      }
      
      position = (position + 100) % 100
      
      if position == 0 {
        timesAtZero += 1
      }
    }
    return String(timesAtZero)
  }
  
  func part2(input: String) -> String {
    var position = 50
    var timesAtZero = 0
    
    
    for line in input.split(separator: "\n") {
      if line == "" { continue }
      var (direction, amount) = read(action: line)
      timesAtZero += amount / 100
      amount = amount % 100
      
      if amount == 0 {
        continue
      }
      
      let prev = position
      if direction == .left {
        position -= amount
      } else {
        position += amount
      }
      
      if position == 0 {
        timesAtZero += 1
      } else if position < 0 && prev != 0 {
        timesAtZero += 1
      } else if position > 99 {
        timesAtZero += 1
      }
      
      position = (position + 100) % 100
    }
    
    return String(timesAtZero)
  }
  
  func read<T>(action: T) -> DialMovement where T: StringProtocol {
    let direction: Direction = if action.starts(with: "R") {
      .right
    } else {
      .left
    }
    let amount = Int(action.dropFirst())!
    return (direction, amount)
  }
}
