//
//  TestExam.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

class TestExamFactory {
    
    static func definition(name: String, expectedAnswer: Double) -> ExamDefinition {
        .init(
            id: "TEST-\(expectedAnswer.description)",
            name: name,
            descriptionText: "Test if this even works!",
            infoText: "Problems in this test require doing nothing and everything, because this is just a test.",
            problemGenerator: TestExamProblemGenerator(expectedAnswer: expectedAnswer)
        )
    }
    
    static func defaultDefinition() -> ExamDefinition {
        definition(name: "Default Definition", expectedAnswer: 1.0)
    }
    
}

class TestExamProblemGenerator: ProblemGenerator {
    
    var expectedAnswer: Double //Stand-in value
    
    init(expectedAnswer: Double) {
        self.expectedAnswer = expectedAnswer
    }
    
    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        .init(
            expectedAnswer: getAndIncrAnswer(),
            questionText: "What is the answer for difficulty \(difficulty)",
            scaleParameterizer: Log10ScaleParameterizer()
        )
    }
    
    private func getAndIncrAnswer() -> Double {
        let prevAns = expectedAnswer
        expectedAnswer += 1.0
        return prevAns
    }
}
