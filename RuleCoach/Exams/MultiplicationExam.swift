//
//  Multiplication.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 8/18/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension ExamDefinition {

    static func multiplicationExam() -> ExamDefinition {
        .init(
            id: "MULTIPLICATION",
            name: "Multiplication",
            descriptionText: "Multi-term multiplicaiton",
            infoText: "Slide the index on the C scale over value on the D scale.  Find the second value on the C scale and read the answer underneath it on the D scale.",
            problemGenerator: MultiplicationExamProblemGenerator()
        )
    }

}

class MultiplicationExamProblemGenerator: ProblemGenerator {
    
    private let scaleParameterizer: ScaleParameterizer = Log10ScaleParameterizer()

    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        let values = generateValues(difficulty: difficulty)
        return Problem(
            expectedAnswer: expectedAnswer(values: values),
            questionText: questionText(values: values),
            scaleParameterizer: scaleParameterizer
        )
    }
    
    private func questionText(values: [Double]) -> String {
        values.map { NumberFormatter.generalFormatter(sigFigs: 4).string(from: $0)! }.joined(separator: " × ")
    }
    
    private func expectedAnswer(values: [Double]) -> Double {
        values.product()
    }
    
    private func generateValues(difficulty: ProblemDifficulty) -> [Double] {
        (0 ..< length(difficulty: difficulty)).map { _ in value(difficulty: difficulty) }
    }
    
    private func length(difficulty: ProblemDifficulty) -> Int {
        switch difficulty {
        case .introductory:
            return 2
        case .easy:
            return Int.random(in: 2 ... 4)
        case .normal:
            return Int.random(in: 2 ... 4)
        case .advanced:
            return Int.random(in: 2 ... 4)
        case .master:
            return Int.random(in: 2 ... 4)
        }
    }
    
    private func value(difficulty: ProblemDifficulty) -> Double {
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
