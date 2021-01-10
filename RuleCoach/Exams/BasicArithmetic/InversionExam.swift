//
//  InversionExam.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 8/23/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension ExamDefinition {
    
    static func inversionExam() -> ExamDefinition {
        .init(
            id: "INVERSION",
            name: "Inversion",
            descriptionText: "Computation of 1/x fractions",
            infoText: "Slide the cursor over the denominator on C and read off the inverse on the CI scale.",
            problemGenerator: InversionExamProblemGenerator()
        )
    }
    
}

class InversionExamProblemGenerator: ProblemGenerator {
    
    private let scaleParameterizer: ScaleParameterizer = ReverseLog10ScaleParameterizer()
    
    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        let denom = denominator(difficulty: difficulty)
        return Problem(
            expectedAnswer: 1.0 / denom,
            questionText: .fractional(numerator: "1", denominator: denom.formatted()),
            scaleParameterizer: scaleParameterizer
        )
    }
    
    private func denominator(difficulty: ProblemDifficulty) -> Double {
        switch difficulty {
        case .introductory:
            return scaleParameterizer.randomScaleValue(inU: 0.0 ..< 1.0)
        case .easy:
            return scaleParameterizer.randomScaleValue(inU: 0.0 ..< 2.0)
        case .normal:
            return scaleParameterizer.randomScaleValue(inU: -2.0 ..< 2.0)
        case .advanced:
            return scaleParameterizer.randomScaleValue(inU: -3.0 ..< 3.0)
        case .master:
            return scaleParameterizer.randomScaleValue(inU: -6.0 ..< 6.0)
        }
    }
    
}
