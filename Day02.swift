//
//  Day02.swift
//  AdventOfCode-2025
//
//  Created by Matthew Dickson on 12/8/25.
//
import Darwin

class Day02: Solution {
  typealias Range = (start: Int64, end: Int64)
  
  func part1(input: String) -> String {
    let ranges = parse(ranges: input)
    
    var sillySum: Int64  = 0
    for r in ranges {
      var repeated = nextPrefix(from: r.start)
      var silly = createSilly(repeating: repeated)
      while silly <= r.end {
        if silly >= r.start && silly <= r.end {
          sillySum += silly
        }
        repeated += 1
        silly = createSilly(repeating: repeated)
      }
    }
    return "\(sillySum)"
  }
  
  func part2(input: String) -> String {
    let ranges = parse(ranges: input)
    var sillySum: Int64 = 0
    var used = Set<Int64>()
    
    for r in ranges {
      let minDigits = countDigits(in: r.start)
      let maxDigits = countDigits(in: r.end)
      var repeated: Int64 = 1 // There's a more optimal way to pick a starting point but this is fast enough
      while countDigits(in: repeated) <= maxDigits / 2 {
        for digits in minDigits...maxDigits {
          let repetitions = digits / countDigits(in: repeated)
          let silly = createSilly(repeating: repeated, times: repetitions)
          if silly >= r.start && silly <= r.end && repetitions > 1 && used.insert(silly).inserted {
            sillySum += silly
          }
          if silly >= r.end {
            break
          }
        }
        repeated += 1
      }
    }
    return "\(sillySum)"
  }
  
  func parse(ranges: String) -> [Range] {
    return ranges.split(separator: ",")
      .filter { range in !range.isEmpty }
      .map { range in range.split(separator: "-") }
      .map { range in
        (
          start: Int64(range[0].trimmingCharacters(in: .whitespacesAndNewlines))!,
          end: Int64(range[1].trimmingCharacters(in: .whitespacesAndNewlines))!
        )
      }
  }
  
  func countDigits(in val: Int64) -> Int {
    var digits = 0
    var v = abs(val)
    while (v > 0) {
      digits += 1
      v /= 10
    }
    return digits
  }
  
  func nextPrefix(from start: Int64) -> Int64 {
    let places = countDigits(in: start)
    return findPrefix(for: start, places: places / 2)
  }
  
  func findPrefix(for val: Int64, places: Int) -> Int64 {
    // 99, 2 -> 9,9
    // 99, 3 -> 100,100 -> 10 ** 2
    // 99, 4 -> 1000,1000 -> 10 ** 3
    // 99, 5 -> 1000,1000 -> 10 ** 4
    
    
    // 101, 2 -> 1010
    // 101, 3 -> 101101
    // 101, 4 -> 1000,1000
    let placesInVal = countDigits(in: val)
    if placesInVal < places {
      return Int64(pow(10.0, Double(places)))
    }
    return Int64(pow(10.0, Double(places - 1)))
  }
  
  func createSilly(repeating: Int64, times: Int = 2) -> Int64 {
    let places = countDigits(in: repeating)
    let shift = Int64(pow(10.0, Double(places)))
    var result = repeating
    for _ in 1..<times {
      result = result * shift + repeating
    }
    return result
  }
}
