//
//  NaturalExponentsExam.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 9/2/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension ExamDefinition {
    
    static func naturalExponents() -> ExamDefinition {
        .init(id: "NATURAL_EXP",
              name: "Natural Exponents",
              descriptionText: "Exponents of \(MathSymbols.e)",
              infoText: """
For exponents greater than zero:
Place the cursor over the exponent value on the D scale (moving the decimal point as necessary).
Find the correct LL scale for the for the exponent value and read the value from under the cursor.

For exponents less than zero:
Place the cursor over the exponent value on the D scale (moving the decimal point as necessary).
Find the correct LL/ scale for the for the exponent value and read the value from under the cursor.

Note that a small number of slide rules have a decedal LL scale, and thus the procedure for natural exponents requires use of the cahnge-of-base procedure explored in the aexponents of arbitrary base exam.
""",
              problemGenerator: NaturalExponentsProblemGenerator()
        )
    }
    
}

class NaturalExponentsProblemGenerator: ProblemGenerator {
    
    //TODO: Some rules, like teh Pickett N-4, use LL base 10 instead of base e! Make this be a parameter.
    //TODO: To make be a parameter, needs to come from user defaults OR make generateProblem somehow take extra parameters.
    //      Another way to do it is to make it be a parameter to the class, and change the class when the defaults changes?
    //      Another way would be a closure or binding parameter to the class to inject functionality.
    
    private let outScaleParameterizer: ScaleParameterizer = Log10ScaleParameterizer()
    
    private let baseValue = Double.e
    private let baseText = MathSymbols.e
    
    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        let exponentIsGreaterThanOne = chooseIfExponentIsGreaterThanOne(difficulty: difficulty)
        let inScaleParameterizer: ScaleParameterizer = exponentIsGreaterThanOne ? LogLogScaleParameterizer() : InvertedLogLogScaleParameterizer()
        let exponentValue = generateExponent(difficulty: difficulty, inScaleParameterizer: inScaleParameterizer)
        return Problem(
            expectedAnswer: pow(baseValue, exponentValue),
            questionText: .exponential(baseLine: baseText, exponent: exponentValue.formatted()),
            scaleParameterizer: outScaleParameterizer
        )
    }
    
    private func chooseIfExponentIsGreaterThanOne(difficulty: ProblemDifficulty) -> Bool {
        switch difficulty {
        case .introductory:
            return true
        case .easy:
            return true
        case .normal:
            return Bool.random()
        case .advanced:
            return Bool.random()
        case .master:
            return Bool.random()
        }
    }
    
    private func generateExponent(difficulty: ProblemDifficulty, inScaleParameterizer: ScaleParameterizer) -> Double {
        switch difficulty {
        case .introductory:
            return inScaleParameterizer.randomScaleValue(inU: 0.0 ..< 1.0) //LL3
        case .easy:
            return inScaleParameterizer.randomScaleValue(inU: -1.0 ..< 1.0) //LL3, LL2
        case .normal:
            return inScaleParameterizer.randomScaleValue(inU: -2.0 ..< 1.0) //LL3, LL2, LL1
        case .advanced:
            return inScaleParameterizer.randomScaleValue(inU: -3.0 ..< 1.0) //LL3, LL2, LL1, LL0
        case .master:
            return inScaleParameterizer.randomScaleValue(inU: -3.0 ..< 2.0) //LL4 (for rules that have it) through LL0
        }
    }
    
}
