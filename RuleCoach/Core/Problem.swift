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
    var answer: Double
}

protocol ProblemGenerator {
    func generateProblem(difficulty: ProblemDifficulty) -> Problem
}

enum ProblemDifficulty: String, CaseIterable {
    case introductory = "Introductory"
    case easy = "Easy"
    case normal = "Normal"
    case advanced = "Advanced"
    case master = "Master"
}

enum ProblemDisplayType {
    case singleLine, fractional
}

struct Problem {
    var displayType: ProblemDisplayType
    var questionText: String? = nil
    var questionNumeratorText: String? = nil
    var questionDenominatorText: String? = nil
    var expectedAnswer: Double
    var scaleParameterizer: ScaleParameterizer //Put here to allow for mixed problem exams.
    
    init(expectedAnswer: Double, questionText: String, scaleParameterizer: ScaleParameterizer) {
        self.displayType = .singleLine
        self.questionText = questionText
        self.expectedAnswer = expectedAnswer
        self.scaleParameterizer = scaleParameterizer
    }
    
    init(expectedAnswer: Double, questionNumeratorText: String, questionDenominatorText: String, scaleParameterizer: ScaleParameterizer) {
        self.displayType = .fractional
        self.questionNumeratorText = questionNumeratorText
        self.questionDenominatorText = questionDenominatorText
        self.expectedAnswer = expectedAnswer
        self.scaleParameterizer = scaleParameterizer
    }
}

protocol ScaleParameterizer {
    func parameterize(value: Double) -> Double
    func valuize(u: Double) -> Double
}
