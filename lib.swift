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
}
