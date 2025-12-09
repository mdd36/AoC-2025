//
//  Day05.swift
//  AdventOfCode-2025
//
//  Created by Matthew Dickson on 12/8/25.
//

class Day05 : Solution {
  
  typealias Range = (start: Int, end: Int)
  
  func part1(input: String) -> String {
    let (ranges, ingredients) = parse(input)
    let coalesced = coalesce(ranges: ranges)
    var freshCnt = 0
    
    for ingredient in ingredients {
      let rangeIndex = coalesced.bisectLeft(for: ingredient) { range in range.end }
      let range = coalesced[rangeIndex]
      if ingredient >= range.start && ingredient <= range.end {
        freshCnt += 1
      }
    }
    return "\(freshCnt)"
  }
  
  func part2(input: String) -> String {
    let (ranges, _) = parse(input)
    let coalesced = coalesce(ranges: ranges)
    var totalFresh = 0
    
    for range in coalesced {
      totalFresh += (range.end - range.start) + 1
    }
    
    return "\(totalFresh)"
  }
  
 
  func parse(_ input: String) -> (ranges: [Range], ingredients: [Int]) {
    let splitInput = input.split(separator: "\n\n")
    
    let ranges = splitInput[0].split(separator: "\n")
      .compactMap { line in line.trim() }
      .map { line in line.split(separator: "-").map { Int($0)! } }
      .map { range in (start: range[0], end: range[1]) }
    
    let ingredients: [Int] = splitInput[1].split(separator: "\n")
      .compactMap { line in line.trim() }
      .map { Int($0)! }
    return (ranges: ranges, ingredients: ingredients)
  }
  
  func coalesce(ranges: [Range]) -> [Range] {
    let sortedRanges = ranges.sorted(by: { a, b in a.start < b.start })
    var coalesed: [Range] = []
    var i = 0
    
    while i < ranges.count {
      var range = sortedRanges[i]
      i += 1
      while i < ranges.count && sortedRanges[i].start <= range.end {
        range.end = max(range.end, sortedRanges[i].end)
        i += 1
      }
      coalesed.append(range)
    }
    
    return coalesed
  }
}
