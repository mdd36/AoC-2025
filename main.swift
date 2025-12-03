//
//  main.swift
//  AdventOfCode-2025
//
//  Created by Matthew Dickson on 12/2/25.
//

import Foundation

protocol Solution {
  func part1(input: String) -> String
  func part2(input: String) -> String
}

if CommandLine.argc < 2 {
  print("Must provide a day")
  print("Usage: ./aoc <day> <filename>")
  exit(1)
}

if CommandLine.argc < 3 {
  print("Must provide a filename")
  print("Usage: ./aoc <day> <filename>")
  exit(1)
}

guard let day = Int(CommandLine.arguments[1]) else {
  print("Must provide a digit for day, got \(CommandLine.arguments[1])")
  print("Usage: ./aoc <day> <filename>")
  exit(1)
}

let filename = CommandLine.arguments[2]

if day < 1 || day > 25 {
  print("Must provide a digit between 1 and 25 for day, got \(day)")
  print("Usage: ./aoc <day> <filename>")
  exit(1)
}

let homeDirectory = FileManager.default.homeDirectoryForCurrentUser
let dataFileUrl = homeDirectory.appending(components: "workplace", "AdventOfCode", "2025", "AdventOfCode-2025", "input", String(format:"%02d", day), filename)
let input = try String(contentsOf: dataFileUrl, encoding: .utf8)
//else {
//  print("Failed to read input")
//  exit(1)
//}

let solver: Solution? = switch day {
case 1: Day01()
default: nil
}

guard let solver else {
  print("Solver not implemented for day \(day)")
  exit(0)
}

var tic = Date()
let part1Ans = solver.part1(input: input)
var duration = Date().timeIntervalSince(tic)
print("Part 1: \(part1Ans) (took \(String(format: "%0.2f", duration))s)")

tic = Date()
let part2Ans = solver.part2(input: input)
duration = Date().timeIntervalSince(tic)
print("Part 2: \(part2Ans) (took \(String(format: "%0.2f", duration))s)")
