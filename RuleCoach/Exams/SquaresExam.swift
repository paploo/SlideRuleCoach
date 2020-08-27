//
//  SquaresExam.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 8/26/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation


extension ExamDefinition {
    
    static func squaresExam() -> ExamDefinition {
        .init(id: "SQUARES",
              name: "Squares",
              descriptionText: "Squares, sometimes multiplied by a coefficient.",
              infoText: """
Standard Method:
Find the value on the C scale, and read the square off of the B or A scale.
If there is a coefficient, slide the index of C over the base value on D, then read the answer on A over thecoefficient on B.

Alternative Method:
If you have a square-root scale, then find the value on the square-root scale and read off the answer from the D scale.
If there is a coefficient, slide the index of the C scale over the square found on the D scale and multiply normally.

Note that the 𝝙𝘶 values with the alternative method will be half what they should be because of the effective use of your square-root scale as a large D scale, and your C/D scales as large B/A scales.
""",
              problemGenerator: SquaresExamProblemGenerator()
        )
    }
    
}

class SquaresExamProblemGenerator: ProblemGenerator {
    
    private let cScaleParameterizer: ScaleParameterizer = Log10ScaleParameterizer()
    private let squareScaleParameterizer: ScaleParameterizer = SquareScaleParameterizer()
    
    private let exponentValue: Double = 2.0
    private let exponentText: String = MathSymbols.square
    
    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        let baseValue = generateBase(difficulty: difficulty)
        return Problem(
            expectedAnswer: pow(baseValue, exponentValue),
            questionText: "\(baseValue.formatted())\(exponentText)",
            scaleParameterizer: squareScaleParameterizer
        )
    }
    
    private func generateBase(difficulty: ProblemDifficulty) -> Double {
        switch difficulty {
        case .introductory:
            return Double(Int.random(in: 1 ... 10))
        case .easy:
            return cScaleParameterizer.randomScaleValue(inU: 0.0 ..< 1.0)
        case .normal:
            return cScaleParameterizer.randomScaleValue(inU: -1.0 ..< 2.0)
        case .advanced:
            return cScaleParameterizer.randomScaleValue(inU: -2.0 ..< 2.0)
        case .master:
            return cScaleParameterizer.randomScaleValue(inU: -4.0 ..< 4.0)
        }
    }
    
}
