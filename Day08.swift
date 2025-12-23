//
//  Day08.swift
//  AdventOfCode-2025
//
//  Created by Matthew Dickson on 12/11/25.
//
import Darwin

class Day08 : Solution {
  
  struct Point : Equatable, Hashable {
    let x: Int
    let y: Int
    let z: Int
    
    init(x: Int, y: Int, z: Int) {
      self.x = x
      self.y = y
      self.z = z
    }
    
    func distance(to other: Point) -> Double {
      return sqrt(Double(
        (x - other.x) * (x - other.x) +
        (y - other.y) * (y - other.y) +
        (z - other.z) * (z - other.z)
      ))
    }
  }
  
  func part1(input: String) -> String {
    let points = parse(input)
    let pairsByDist = points.pairwise()
      .map { (a, b) in (a.distance(to: b), a, b) }
      .sorted() { (a,b) in a.0 < b.0 }
    let uf = UnionFind(items: points)
    for i in 0...999 {
      let (_, a, b) = pairsByDist[i]
      _ = uf.union(a, b)
    }
    let roots = uf.parents.compactMap() { (key, value) in if key == value { key } else { nil }}
    let sizes = roots
      .map { p in uf.sizes[p]! }
      .sorted()
    return "\(sizes.suffix(3).reduce(1) { acc, val in acc * val })"
  }
  
  func part2(input: String) -> String {
    let points = parse(input)
    let pairsByDist = points.pairwise()
      .map { (a, b) in (a.distance(to: b), a, b) }
      .sorted() { (a,b) in a.0 < b.0 }
    let uf = UnionFind(items: points)
    var connectedComponents = points.count
    var ans: Int? = nil
    var idx = 0
    while connectedComponents > 1 {
      let (_, a, b) = pairsByDist[idx]
      if uf.union(a, b) {
        connectedComponents -= 1
        ans = a.x * b.x
      }
      idx += 1
    }
    
    guard let ans else { return "!! Error, no answer !!" }
    return "\(ans)"
  }
  
  func parse(_ input: String) -> [Point] {
   return input.split(separator: "\n")
      .compactMap { line in line.trim() }
      .map { line in line.split(separator: ",") }
      .map { Point(x: Int($0[0])!, y: Int($0[1])!, z: Int($0[2])!) }
  }
}
