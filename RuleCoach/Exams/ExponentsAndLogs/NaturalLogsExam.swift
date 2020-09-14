//
//  NaturalLogsExam.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 9/13/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension ExamDefinition {
    
    static func naturalLogs() -> ExamDefinition {
        .init(id: "NATURAL_LOG",
              name: "Natural Logs",
              descriptionText: "Log Base \(MathSymbols.e)",
              infoText: """
If the value is greater than 1:
Place the cursor over the value on the appropriate LL scale.
Read the answer off the D scale, moving the decimal as is appropriate for the LL scale used.

If the value is less than 1:
Place the cursor over the value on the appropriate LL/ scale.
Read the answer off the D scale, moving the decimal as is appropriate for the LL/ scale used.
""",
              problemGenerator: NaturalLogsProblemGenerator()
        )
    }
    
}


class NaturalLogsProblemGenerator: ProblemGenerator {
    
    private let outScaleParameterizer: ScaleParameterizer = Log10ScaleParameterizer()
    
    private let functionText = MathSymbols.log
    
    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        let isPositiveValue = chooseIfValuePositive(difficulty: difficulty)
        let inScaleParamterizer: ScaleParameterizer = isPositiveValue ? LogLogScaleParameterizer() : InvertedLogLogScaleParameterizer()
        let value = generateValue(difficulty: difficulty, inScaleParameterizer: inScaleParamterizer)
        return Problem(
            expectedAnswer: log(value),
            questionText: .singleLine(MathSymbols.function(functionText, value.formatted())),
            scaleParameterizer: outScaleParameterizer
        )
    }
    
    private func chooseIfValuePositive(difficulty: ProblemDifficulty) -> Bool {
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
    
    private func generateValue(difficulty: ProblemDifficulty, inScaleParameterizer: ScaleParameterizer) -> Double {
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
