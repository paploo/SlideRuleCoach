//
//  TestExam.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

class TestExam: Exam {
    
    static let definition: ExamDefinition = .init(
        id: "TEST",
        name: "Test Exam",
        descriptionText: "Test if this even works!",
        infoText: "Problems in this test require doing nothing and everything, because this is just a test.",
        problemGenerator: TestExamProblemGenerator()
    )
    
}

class TestExamProblemGenerator: ProblemGenerator {
    
    //TODO: Put in a library of these?
    class DirectScaleParameterizer: ScaleParameterizer {
        func parameterize(value: Double) -> Double {
            value
        }
        
        func valuize(u: Double) -> Double {
            u
        }
    }
    
    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        .init(
            expectedAnswer: 3,
            questionText: "three",
            scaleParameterizer: DirectScaleParameterizer()
        )
    }
}
