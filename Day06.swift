//
//  Day06.swift
//  AdventOfCode-2025
//
//  Created by Matthew Dickson on 12/11/25.
//

import Darwin

class Day06 : Solution {
  enum Operation { case add, mul }
  typealias Problem = (values: [Int], operation: Operation)
  
  func part1(input: String) -> String {
    let result = parse(input)
      .map { problem in evaluate(problem) }
      .sum()
    return "\(result)"
  }
  
  func part2(input: String) -> String {
    let result = parseByColumn(input)
      .map { problem in evaluate(problem) }
      .sum()
    return "\(result)"
  }
  
  func parse(_ input: String) -> [Problem] {
    let lines = input.split(separator: "\n")
      .compactMap { line in line.trim() }
    
    let nums = lines.dropLast()
      .map { line in line.split(separator: /\s+/).map { Int($0)! } }
    let transposed = (0..<nums[0].count)
      .map { idx in nums.map { $0[idx] } }
    
    let ops = lines.last!
      .split(separator: /\s+/)
      .map { op in
        if op == "+" {
          return Operation.add
        } else {
          return Operation.mul
        }
      }
    
    return zip(ops, transposed).map { operation, values in (values, operation) }
  }
  
  func parseByColumn(_ input: String) -> [Problem] {
    let lines = input.split(separator: "\n")
    
    let numbers = lines.dropLast()
    let numCols = numbers[0].count
    
    var currentProblem: [Int] = []
    var problemValues: [[Int]] = []
    
    for i in 0..<numCols {
      var col: [Int] = []
      for s in numbers {
        let strIdx = String.Index(utf16Offset: i, in: s)
        let ch = s[strIdx]
        if let n = ch.wholeNumberValue {
          col.append(n)
        }
      }
      if col.isEmpty {
        problemValues.append(currentProblem)
        currentProblem.removeAll()
      } else {
        let num = col.enumerated()
          .map { idx, n in n * Int(pow(10.0, Double(col.count - idx - 1))) }
          .sum()
        currentProblem.append(num)
      }
    }
    problemValues.append(currentProblem)
      
    let ops = lines.last!
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .split(separator: /\s+/)
      .map { op in
        if op == "+" {
          return Operation.add
        } else {
          return Operation.mul
        }
      }
    
    return zip(problemValues, ops)
      .map { values, op in (values: values, operation: op) }
  }
  
  func evaluate(_ problem: Problem) -> Int {
    return switch problem.operation {
    case .add:
      problem.values.sum()
    case .mul:
      problem.values.prod()
    }
  }
}
