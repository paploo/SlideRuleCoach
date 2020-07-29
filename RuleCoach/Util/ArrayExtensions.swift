//
//  ArrayExtensions.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/28/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension Array where Element: BinaryInteger {
    func average() -> Double {
        let normalizationFactor = 1.0 / Double(count)
        
        return map { Double($0) * normalizationFactor }.sum()
    }
}

extension Array where Element: BinaryFloatingPoint {
    func average() -> Double {
        let normalizationFactor = 1.0 / Double(count)
        
        return map { Double($0) * normalizationFactor }.sum()
    }
}

extension Array where Element: Numeric {
    func sum() -> Element {
        return reduce(.zero, +)
    }
}
