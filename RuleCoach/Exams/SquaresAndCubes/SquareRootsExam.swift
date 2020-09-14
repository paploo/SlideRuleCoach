//
//  SqrtExam.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 8/29/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension ExamDefinition {
    
    static func squareRoots() -> ExamDefinition {
        .init(
            id: "SQRT",
            name: "Square Roots",
            descriptionText: "Square roots, sometimes multiplied by a coefficient",
            infoText: """
Find the value on the A scale, and read off the square root on the D scale.
If there is a coefficient, slide the index of C over the found root on D, and multiply normally.

Alternative Method:
If you hae a square root scale, then find the value on the D scale and read off the answer from the root scale.
If there is a coefficient, write down the value of the root and multiply normaly.

Note that the 𝝙𝘶 values with the alternative method will be twice what they should be because of the effective use of your D scale
a small square-root scale.
""",
            problemGenerator: SquareRootsProblemGenerator()
        )
    }
    
}

class SquareRootsProblemGenerator: ProblemGenerator {
    
    //Generate coefs like they were on the C scale.
    private let coefScaleParameterizer: ScaleParameterizer = Log10ScaleParameterizer()
    
    //We use the A scale to lookup on the D scale.
    private let inScaleParameterizer: ScaleParameterizer = SquareScaleParameterizer()
    private let outScaleParameterizer: ScaleParameterizer = Log10ScaleParameterizer()
    
    private let exponentValue: Double = 0.5
    private let exponentText: String = MathSymbols.sqrt
    
    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        let baseValue = generateBase(difficulty: difficulty)
        let coefValue = generateCoefficient(difficulty: difficulty)
        return Problem(
            expectedAnswer: pow(baseValue, exponentValue) * (coefValue ?? 1.0),
            questionText: .singleLine(questionText(baseValue: baseValue, coefValue: coefValue)),
            scaleParameterizer: outScaleParameterizer
        )
    }
    
    private func questionText(baseValue: Double, coefValue: Double?) -> String {
        let baseText = "\(exponentText)\(baseValue.formatted())"
        if let coef = coefValue {
            return "\(coef.formatted()) \(MathSymbols.times) \(baseText)"
        } else {
            return baseText
        }
    }
    
    private func generateCoefficient(difficulty: ProblemDifficulty) -> Double? {
        switch difficulty {
        case .introductory:
            return nil
        case .easy:
            return coefScaleParameterizer.randomScaleValue(inU: 0.0 ..< 1.0)
        case .normal:
            return coefScaleParameterizer.randomScaleValue(inU: -1.0 ..< 2.0)
        case .advanced:
            return coefScaleParameterizer.randomScaleValue(inU: -2.0 ..< 2.0)
        case .master:
            return coefScaleParameterizer.randomScaleValue(inU: -4.0 ..< 4.0)
        }
    }
    
    private func generateBase(difficulty: ProblemDifficulty) -> Double {
        switch difficulty {
        case .introductory:
            return inScaleParameterizer.randomScaleValue(inU: 0.0 ..< 1.0)
        case .easy:
            return inScaleParameterizer.randomScaleValue(inU: 0.0 ..< 1.0)
        case .normal:
            return inScaleParameterizer.randomScaleValue(inU: -1.0 ..< 2.0)
        case .advanced:
            return inScaleParameterizer.randomScaleValue(inU: -2.0 ..< 2.0)
        case .master:
            return inScaleParameterizer.randomScaleValue(inU: -4.0 ..< 4.0)
        }
    }
    
}
