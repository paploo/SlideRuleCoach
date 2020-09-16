//
//  ArbitraryLogsExam.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 9/15/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension ExamDefinition {
    
    static func arbitraryLogs() -> ExamDefinition {
        .init(
            id: "ARBITRARY_LOGS",
            name: "Logarithms",
            descriptionText: "Logarithms of an arbitrary base",
            infoText: """
Find the base on the LL scale (or LL/, if less than 1).
Use the cursor to align the index on C with base on the LL scale.

If the argument is greater than 1:
Read the argument on the corresponding LL scale, and the answer on the C scale.
Adjust the decimal place according to the coresponding LL scale.

If the exponent is less than 1:
Read the argument on the opposing LL scale, and the answer on the C scale.
Adjust the decimal place according to the coresponding LL scale.

Note that to determine the the correcet LL or LL/ scale to choose from, it can be helpful to picture them as two continuous scales, mentally "wrapping around" an extra long rule (with repeated C/D scales).
""",
            problemGenerator: ArbitraryLogsProblemGenerator()
        )
    }
    
}

class ArbitraryLogsProblemGenerator: ProblemGenerator {
    
    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        //First, we make sure the base is within the acceptable range.
        let isBaseGreaterThanOne = chooseIfGreaterThanOne(difficulty: difficulty)
        let inScaleParameterizer: ScaleParameterizer = isBaseGreaterThanOne ? LogLogScaleParameterizer() : InvertedLogLogScaleParameterizer()
        let base = generateValue(difficulty: difficulty, scaleParameterizer: inScaleParameterizer)
        
        //Then we make sure the argument is within the acceptable range.
        let isArgumentGreaterThanOne = chooseIfGreaterThanOne(difficulty: difficulty)
        let outScaleParameterizer: ScaleParameterizer = isArgumentGreaterThanOne ? LogLogScaleParameterizer() : InvertedLogLogScaleParameterizer()
        let argument = generateValue(difficulty: difficulty, scaleParameterizer: outScaleParameterizer)
        
        //And then we back-calculate the exponent that gives us the answer.
        let exponent = log(argument) / log(base)
        
        return Problem(
            expectedAnswer: exponent,
            questionText: .logarithmic(base: base.formatted(), argument: argument.formatted()),
            scaleParameterizer: outScaleParameterizer
        )
    }
    
    private func chooseIfGreaterThanOne(difficulty: ProblemDifficulty) -> Bool {
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
    
    private func generateValue(difficulty: ProblemDifficulty, scaleParameterizer: ScaleParameterizer) -> Double {
        switch difficulty {
        case .introductory:
            return scaleParameterizer.randomScaleValue(inU: 0.0 ..< 1.0) //LL3
        case .easy:
            return scaleParameterizer.randomScaleValue(inU: -2.0 ..< 1.0) //LL3, LL2, LL1
        case .normal:
            return scaleParameterizer.randomScaleValue(inU: -2.0 ..< 1.0) //LL3, LL2, LL1
        case .advanced:
            return scaleParameterizer.randomScaleValue(inU: -3.0 ..< 1.0) //LL3, LL2, LL1, LL0
        case .master:
            return scaleParameterizer.randomScaleValue(inU: -3.0 ..< 2.0) //LL4 (for rules that have it) through LL0
        }
    }
    
}
