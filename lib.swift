//
//  lib.swift
//  AdventOfCode-2025
//
//  Created by Matthew Dickson on 12/8/25.
//

extension StringProtocol {
  func trim() -> String? {
    let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
    if trimmed.isEmpty {
      return nil
    } else {
      return trimmed
    }
  }
}

extension Array where Element : AdditiveArithmetic {
  func sum() -> Element {
    return reduce(Element.zero) { acc, elem in acc + elem }
  }
}

extension Array where Element == Int {
  func prod() -> Int {
    if isEmpty {
      return 0
    }
    return reduce(1) { acc, elem in acc * elem }
  }
}

extension Array {
  func bisectLeft<T>(for elem: Element, key: (Element) -> T) -> Index where T : Comparable {
    return bisectLeft(for: key(elem), key: key)
  }
  
  func bisectLeft<T>(for elem: T, key: (Element) -> T) -> Index where T : Comparable {
    var lo = 0
    var hi = count - 1
    
    while lo < hi {
      let mid = lo + (hi - lo) / 2
      if key(self[mid]) < elem {
        lo = mid + 1
      } else {
        hi = mid
      }
    }
    
    return Index(lo)
  }
  
  func bisectRight<T>(for elem: Element, key: (Element) -> T) -> Index where T : Comparable {
    return bisectRight(for: key(elem), key: key)
  }
  
  func bisectRight<T>(for elem: T, key: (Element) -> T) -> Index where T : Comparable {
    var lo = 0
    var hi = count - 1
    
    while lo < hi {
      let mid = lo + (hi - lo) / 2
      if elem < key(self[mid]) {
        hi = mid
      } else {
        lo = mid + 1
      }
    }
    
    return Index(lo)
  }
  
  func pairwise() -> [(Element, Element)] {
    return (0..<count)
      .flatMap { i in ((i+1)..<count).flatMap { j in (self[i], self[j]) } }
  }
}

class UnionFind<T : Hashable & Equatable> {
  var parents: [T: T]
  var sizes: [T: Int]
  
  init(items: [T]) {
    self.parents = items.reduce(into: [:]) { result, val in result[val] = val }
    self.sizes = items.reduce(into: [:]) { result, val in result[val] = 1 }
  }
  
  func union(_ first: T, _ second: T) -> Bool {
    guard
      let firstP = find(first),
      let secondP = find(second),
      let firstSize = sizes[firstP],
      let secondSize = sizes[secondP]
    else {
      return false
    }
    
    if firstP == secondP {
      return false
    }
    
    if firstSize < secondSize {
      parents[secondP] = firstP
      sizes[firstP] = firstSize + secondSize
    } else {
      parents[firstP] = secondP
      sizes[secondP] = firstSize + secondSize
    }
    return true
  }
  
  func find(_ val: T) -> T? {
    guard let p = parents[val] else {
      return nil
    }
    
    if p == val {
      return val
    } else {
      let newParent = find(p)!
      parents[val] = newParent
      return newParent
    }
  }
}
