//
//  ProblemGeneratorTools.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 8/19/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

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

extension NumberFormatter {
    
    /**
     * The standardized formatter for numbers output in the problem text, where applicable.
     */
    static var questionTextFormatter: NumberFormatter {
        NumberFormatter.generalFormatter(sigFigs: 4)
    }
    
}

extension Array where Element: BinaryFloatingPoint {
    
    /**
     * Simplify building sets of numbers joined by a separator.
     */
    func joinWithFormatter(separator: String, numberFormatter: NumberFormatter = NumberFormatter.questionTextFormatter) -> String {
        map { Double($0).formatted(with: numberFormatter) }.joined(separator: separator)
    }
    
}

extension Double {
    
    func formatted(with numberFormatter: NumberFormatter = NumberFormatter.questionTextFormatter) -> String {
        numberFormatter.string(from: self) ?? "--"
    }
    
}

extension String {
    
    /**
     * Pad the front and back of the given string with the given string.
     *
     * Default padding is an empty string.
     *
     * Useful for making separators out of math symbols.
     */
    func padded(with wrapping: String) -> String {
        return padded(withPrefix: wrapping, withSuffix: wrapping)
    }
    
    /**
     * Pad the string with a prefix and/or suffix.
     */
    func padded(withPrefix: String = "", withSuffix: String = "") -> String {
        return "\(withPrefix)\(self)\(withSuffix)"
    }
    
}

class MathSymbols {
    
    static let mathematicalItalicSmallAlphabet = "𝑎𝑏𝑐𝑑𝑒𝑓𝑔ℎ𝑖𝑗𝑘𝑙𝑚𝑛𝑜𝑝𝑞𝑟𝑠𝑡𝑢𝑣𝑤𝑥𝑦𝑧"
    
    static let plus = "+"
    static let minus = "−"
    static let times = "×"
    static let divide = "÷"
    
    static let sqrt = "√"
    static let cuberoot = "∛"
    static let square = "²"
    static let cube = "³"
    
    static let sin = "𝑠𝑖𝑛"
    static let cos = "𝑐𝑜𝑠"
    static let tan = "𝑡𝑎𝑛"
    
    static let asin = ""
    static let acos = ""
    static let atan = ""
    
    static let pow = "𝑝𝑜𝑤"
    static let log = "𝑙𝑜𝑔"
    static let exp = "𝑒𝑥𝑝"
    static let ln = "𝑙𝑛"
    
    static let log2 = "𝑙𝑜𝑔₂"
    static let log10 = "𝑙𝑜𝑔₁₀"
    
    static let degree = "°"
    static let arcmin = "′"
    static let arcsec = "″"
    static let radian = "㎭"
    
    static let pi = "𝜋"
    static let e = "𝑒"
    
    static let leftParen = "⟮"
    static let rightParen = "⟯"
    static let parameterSeparator = ","
    
    /**
     * Helper for formatting a function.
     */
    static func function(_ name: String, _ parameters: String...) -> String {
        return name + leftParen + parameters.joined(separator: parameterSeparator.padded(withSuffix: " ")) + rightParen
    }
}
