//
//  Problem.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

struct WorkedProblem {
    var problem: Problem
    var submittedAnswer: Double
}

protocol ProblemGenerator {
    func generateProblem(difficulty: ProblemDifficulty) -> Problem
}

enum ProblemDifficulty: String, CaseIterable {
    case introductory = "Intro"
    case easy = "Easy"
    case normal = "Normal"
    case advanced = "Advanced"
    case master = "Master"
}

enum QuestionText {
    case singleLine(_ text: String)
    case fractional(numerator: String, denominator: String)
    case exponential(baseLine: String, exponent: String)
}

struct Problem {
    var questionText: QuestionText
    var expectedAnswer: Double
    var scaleParameterizer: ScaleParameterizer //The *answer's* scale parameterizer; Put here to allow for mixed problem exams.
    
    init(expectedAnswer: Double, questionText: QuestionText, scaleParameterizer: ScaleParameterizer) {
        self.questionText = questionText
        self.expectedAnswer = expectedAnswer
        self.scaleParameterizer = scaleParameterizer
    }
}
