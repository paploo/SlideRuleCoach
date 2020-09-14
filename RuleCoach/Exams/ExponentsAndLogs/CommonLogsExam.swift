//
//  CommonLogExam.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 8/30/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension ExamDefinition {
    
    static func commonLogs() -> ExamDefinition {
        .init(
            id: "COMMON_LOG",
            name: "Common Logs",
            descriptionText: "Log Base-10",
            infoText: """
If the value is greater than one:
Move the decimal to the left (i.e. repeatedly divide by 10) until the value is between one and ten.
Place the cursor over the value on the D scale, and read the fractional part of the logarithm on the L scale.
Add to it the integer part, determined as the number of places that the decimal was moved to the left.

If the value is less than one:
Move the decimal to the right (i.e. repeadelty multiply by 10) until the value is between one and ten.
Place the cursor over the value on the CI scale, and read the fractional part of the logarithm on the L scale.
Add to it the integer part, determined as one less than the number of places that the decimal was moved to the right.
""",
            problemGenerator: CommonLogsProblemGenerator()
        )
    }
    
}

class CommonLogsProblemGenerator: ProblemGenerator {
    
    private let inScaleParameterizer: ScaleParameterizer = Log10ScaleParameterizer()
    private let outScaleParameterizer: ScaleParameterizer = UnityScaleParameterizer()
    
    private let functionText = MathSymbols.log10
    
    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        let value = generateValue(difficulty: difficulty)
        return Problem(
            expectedAnswer: log10(value),
            questionText: .singleLine(MathSymbols.function(functionText, value.formatted())),
            scaleParameterizer: outScaleParameterizer
        )
    }
    
    private func generateValue(difficulty: ProblemDifficulty) -> Double {
        switch difficulty {
        case .introductory:
            return inScaleParameterizer.randomScaleValue(inU: 0.0 ..< 1.0)
        case .easy:
            return inScaleParameterizer.randomScaleValue(inU: -2.0 ..< 2.0)
        case .normal:
            return inScaleParameterizer.randomScaleValue(inU: -3.0 ..< 3.0)
        case .advanced:
            return inScaleParameterizer.randomScaleValue(inU: -4.0 ..< 4.0)
        case .master:
            return inScaleParameterizer.randomScaleValue(inU: -6.0 ..< 6.0)
        }
    }
    
}
