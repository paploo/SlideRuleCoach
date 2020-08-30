//
//  CubeRootsExam.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 8/29/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension ExamDefinition {
    
    static func cubeRoots() -> ExamDefinition {
        .init(id: "CUBE_ROOTS",
              name: "Cube Roots",
              descriptionText: "Cube roots",
              infoText: """
Find the value on the K scale and read off the cube root on the D scale.
If there is a coefficient, slide the index of C over the root found on D, and multiply normally.
""",
              problemGenerator: SquareRootsProblemGenerator()
        )
    }
    
}

class CubeRootsProblemGenerator {
    
    //We use the K scale to lookup on the D scale.
    private let inScaleParameterizer: ScaleParameterizer = CubeScaleParameterizer()
    private let outScaleParameterizer: ScaleParameterizer = Log10ScaleParameterizer()
    
    private let exponentValue: Double = 1.0/3.0
    private let exponentText: String = MathSymbols.cuberoot
    
    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        let baseValue = generateBase(difficulty: difficulty)
        return Problem(
            expectedAnswer: pow(baseValue, exponentValue),
            questionText: "\(exponentText)\(baseValue.formatted())",
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
