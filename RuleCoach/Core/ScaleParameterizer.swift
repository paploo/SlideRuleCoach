//
//  ScaleParameterizer.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/26/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

/**
 * Converts a value to/from the parameterized position on the face of the sliderule.
 *
 * - `parameterize` takes a value, and returns its location on the face of the sliderule, between 0 and 1.
 * - `valuize` reverses the process, returning the original value for the position on the sliderule.
 *
 * Another way to put it is that if one put the cursor on a position
 * `x` on a scale, `parameterize(x)` would return the value that would be read
 * off of the L scale.
 *
 * Note that in many cases it is useful to consider the scale as wrap-around,
 * providing positive or negative parameterizations.
 *
 * For example, the C/D scales wrap around in either for every multiple of ten,
 * and the LL scals are divided into several scales that are each part of a
 * continuous spiral on a circular rule.
 */
protocol ScaleParameterizer {
    func parameterize(value: Double) -> Double
    func valuize(u: Double) -> Double
}

/**
 * Unity scale parameterizer.
 *
 * Used by the L scale.
 */
class UnityScaleParameterizer: ScaleParameterizer {
    func parameterize(value: Double) -> Double { value }
    func valuize(u: Double) -> Double { u }
}

/***
 * Log10 Scale parameterizer.
 *
 * Used by the C and D scales.
 */
class Log10ScaleParameterizer: ScaleParameterizer {
    func parameterize(value: Double) -> Double { log10(value) }
    func valuize(u: Double) -> Double { pow(10, u) }
}

/**
 * Log10 parameterizer that runs values in the opposite direction.
 *
 * Used by the CI scale.
 */
class ReverseLog10ScaleParameterizer: ScaleParameterizer {
    func parameterize(value: Double) -> Double { 1 - log10(value) }
    func valuize(u: Double) -> Double { pow(10, 1-u) }
}
