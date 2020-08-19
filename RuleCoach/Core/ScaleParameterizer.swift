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
    
    /**
     * Generate a random value in parameter space, and convert it to a value.
     *
     * e.g. using `0 ..< 1` generates a value randomly placed on the slide rule face and then
     * gives the value that would be read on the scale.
     *
     * Some scales "wrap around" (especially the standard C/D scales), so larger ranges can be useful.
     */
    func randomScaleValue(inU range: Range<Double> = 0.0 ..< 1.0) -> Double {
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
