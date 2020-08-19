//
//  ScaleParameterizer.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/26/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

protocol ScaleParameterizer {
    func parameterize(value: Double) -> Double
    func valuize(u: Double) -> Double
}

extension ScaleParameterizer {
    func random(in range: Range<Double>) -> Double {
        valuize(u: Double.random(in: range))
    }
}

class UnityScaleParameterizer: ScaleParameterizer {
    func parameterize(value: Double) -> Double { value }
    func valuize(u: Double) -> Double { u }
}

class Log10ScaleParameterizer: ScaleParameterizer {
    func parameterize(value: Double) -> Double { log10(value) }
    func valuize(u: Double) -> Double { pow(10, u) }
}

class LogScaleParameterizer: ScaleParameterizer {
    func parameterize(value: Double) -> Double { log(value) }
    func valuize(u: Double) -> Double { exp(u) }
}
