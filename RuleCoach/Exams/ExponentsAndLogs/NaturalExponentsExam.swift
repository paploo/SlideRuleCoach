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

Note that a small number of slide rules have a decedal LL scale, and thus the procedure for natural exponents requires use of the cahnge-of-base procedure tested in the exponents of arbitrary base exam.
""",
              problemGenerator: NaturalExponentsProblemGenerator()
        )
    }
    
}

class NaturalExponentsProblemGenerator: ProblemGenerator {
    
    private let inScaleParameterizer: ScaleParameterizer = Log10ScaleParameterizer()
    
    private let baseValue = Double.e
    private let baseText = MathSymbols.e
    
    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        let isExponentPositive = chooseIfExponentPositive(difficulty: difficulty)
        let outScaleParameterizer: ScaleParameterizer = isExponentPositive ? LogLogScaleParameterizer() : InvertedLogLogScaleParameterizer()
        let exponentValue = isExponentPositive.signDoubleValue() * generateExponent(difficulty: difficulty, inScaleParameterizer: inScaleParameterizer)
        return Problem(
            expectedAnswer: pow(baseValue, exponentValue),
            questionText: .exponential(baseLine: baseText, exponent: exponentValue.formatted()),
            scaleParameterizer: outScaleParameterizer
        )
    }
    
    private func chooseIfExponentPositive(difficulty: ProblemDifficulty) -> Bool {
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
            return inScaleParameterizer.randomScaleValue(inU: -2.0 ..< 1.0) //LL3, LL2, LL1
        case .normal:
            return inScaleParameterizer.randomScaleValue(inU: -2.0 ..< 1.0) //LL3, LL2, LL1
        case .advanced:
            return inScaleParameterizer.randomScaleValue(inU: -3.0 ..< 1.0) //LL3, LL2, LL1, LL0
        case .master:
            return inScaleParameterizer.randomScaleValue(inU: -3.0 ..< 2.0) //LL4 (for rules that have it) through LL0
        }
    }
    
}
