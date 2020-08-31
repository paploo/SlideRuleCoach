//
//  CubesExam.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 8/29/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension ExamDefinition {
    
    static func cubesExam() -> ExamDefinition {
        .init(id: "CUBES",
              name: "Cubes",
              descriptionText: "Cubes",
              infoText: """
Find the value on the D scale, and read its cube off of the K scale.
If there is a coefficient, record the answer and multiply normally.
""",
              problemGenerator: CubesExamProblemGenerator()
        )
    }
    
}

class CubesExamProblemGenerator: ProblemGenerator {
    
    private let inScaleParameterizer: ScaleParameterizer = Log10ScaleParameterizer()
    private let outScaleParameterizer: ScaleParameterizer = CubeScaleParameterizer()
    
    private let exponentValue: Double = 3.0
    private let exponentText: String = MathSymbols.cube
    
    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        let baseValue = generateBase(difficulty: difficulty)
        return Problem(
            expectedAnswer: pow(baseValue, exponentValue),
            questionText: .singleLine("\(baseValue.formatted())\(exponentText)"),
            scaleParameterizer: outScaleParameterizer
        )
    }
    
    private func generateBase(difficulty: ProblemDifficulty) -> Double {
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
            return inScaleParameterizer.randomScaleValue(inU: -4.0 ..< 4.0)
        }
    }
    
}
