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
