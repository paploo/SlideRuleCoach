//
//  CommonExponent.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 8/30/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension ExamDefinition {
    
    static func commonExponents() -> ExamDefinition {
                .init(id: "COMMON_EXP",
                      name: "Base-10 Exponents",
                      descriptionText: "Values raised to the power of ten.",
                      infoText: """
Split the exponent into the integer and fractional components.

If the exponent is positive:
Place the cursor over fractional component on the L scale, read the value of the mantissa on the D-scale.
Multiply the mantissa by the power of ten given by the integer part.

If the exponent is negative:
Place the cursor over the fractional component on the L scale, read the value of the mantissa on the DI scale.
Multiply the mantissa by the power of ten given by the integer part.
""",
                      problemGenerator: CommonExponentsProblemGenerator()
                )
    }
    
}

class CommonExponentsProblemGenerator: ProblemGenerator {
    
    private let inScaleParameterizer: ScaleParameterizer = UnityScaleParameterizer()
    private let outScaleParameterizer: ScaleParameterizer = Log10ScaleParameterizer()
    
    private let baseValue = 10.0
    private let baseText = "10"
    
    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        let exponentValue = generateExponent(difficulty: difficulty)
        return Problem(
            expectedAnswer: pow(baseValue, exponentValue),
            questionText: .exponential(baseLine: baseText, exponent: exponentValue.formatted()),
            scaleParameterizer: outScaleParameterizer
        )
    }
    
    private func generateExponent(difficulty: ProblemDifficulty) -> Double {
        switch difficulty {
        case .introductory:
            return inScaleParameterizer.randomScaleValue(inU: 0.0 ..< 1.0)
        case .easy:
            return inScaleParameterizer.randomScaleValue(inU: 0.0 ..< 2.0)
        case .normal:
            return inScaleParameterizer.randomScaleValue(inU: -1.0 ..< 2.0)
        case .advanced:
            return inScaleParameterizer.randomScaleValue(inU: -2.0 ..< 2.0)
        case .master:
            return inScaleParameterizer.randomScaleValue(inU: -3.0 ..< 3.0)
        }
    }
    
}
