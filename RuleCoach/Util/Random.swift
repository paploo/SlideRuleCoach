//
//  Random.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/28/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension Double {

    /**
     Return a random number that, when expressed in scientific notation, has an exponent in the given range.
     
     Double-precision values may suffer from rounding error, while Decimal-generated ones do not.
     
     The significands are all evenly distributed in 1 ..< 10, and the exponents are all evenly distributed within the given range,
     thus the numbers are not evenly distributed—even in log space. If negatives are allowed, there is a 50% chance of getting a negative value.
     
     - Parameters
        - inExponent: Define the exponent range; For example, if the range is 1 ..< 2, numbers from 1e1 to 1e2 (10 to 100) are generated.
        - sigFigs: The significant figures. If sigFigs is 4, then a number such as 3.142 x 10^n could be produced.
        - allowNegatives: If true, there is a 50% chance the produced number will be negative.
     */
    static func random(inExponent range: Range<Int>, sigFigs: UInt, allowNegatives: Bool = false) -> Double {
        assert(sigFigs <= 17, "Cannot generate a random double to more than 17 sigfigs (got \(sigFigs)).")
        
        let scale = pow(10.0, Double(sigFigs))
        let digits = Double.random(in: 0.1 ..< 1.0)
        let significand = (digits * scale).rounded() / scale //Trick for trimming the digits to the given decimals.
        
        let exponent = range.randomElement() ?? 0
        let sign = allowNegatives ? ([-1.0,1.0].randomElement() ?? 1.0) : 1.0
        
        return sign * significand * pow(10.0, Double(exponent))
    }

}

extension Decimal {
    /**
     Return a random number that, when expressed in scientific notation, has an exponent in the given range.
     
     The significands are all evenly distributed in 1 ..< 10, and the exponents are all evenly distributed within the given range,
     thus the numbers are not evenly distributed—even in log space.  If negatives are allowed, there is a 50% chance of getting a negative value.
     
     - Parameters
        - inExponent: Define the exponent range; For example, if the range is 1 ..< 2, numbers from 1e1 to 1e2 (10 to 100) are generated.
        - sigFigs: The significant figures. If sigFigs is 4, then a number such as 3.142 x 10^n could be produced.
        - allowNegatives: If true, there is a 50% chance the produced number will be negative.
     */
    static func random(inExponent range: Range<Int>, sigFigs: UInt, allowNegatives: Bool = false) -> Decimal {
        assert(sigFigs <= 17, "Cannot generate a random decimal to more than 17 sigfigs (got \(sigFigs)).")
        
        let decimalPlaces = sigFigs - 1 //Since we generate an integer mantissa, we have an extra factor of 10 to take into account.
        let scale = Int64.pow(10, decimalPlaces)
        let mantissa = Int64.random(in: scale ..< (scale * 10)) //The integer mantissa is scaled to act like 0.1 to 1.0 after a -decimalPlaces exponent is applied.
        let significand = Decimal(sign: .plus, exponent: -Int(decimalPlaces), significand: Decimal(mantissa))
        
        let exponent = range.randomElement() ?? 0
        let sign: FloatingPointSign = allowNegatives ? ([.plus, .minus].randomElement() ?? .plus) : .plus
        
        return Decimal(sign: sign, exponent: exponent, significand: significand)
    }
    
    func doubleValue() -> Double {
        (self as NSDecimalNumber).doubleValue
    }
    
}

extension Int64 {
    
    /**
     Raise the base value to a given exponent.
     
     Note that there are no safeties around calling this with too large of an
     exponent, which will result in a crash.
     */
    static func pow(_ base: Int64, _ exponent: UInt) -> Int64 {
        assert(Double(exponent) * log2(Double(base)) <= 64.0, "Need \(Double(exponent) * log2(Double(base))) bits but only have 64.")
        var memo = Int64(1)
        for _ in 0 ..< exponent {
            memo *= base
        }
        return memo
    }
    
}
