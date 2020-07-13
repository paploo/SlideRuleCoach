//
//  Exam.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

struct ExamDefinition: Identifiable {
    var id: String
    var name: String
    var descriptionText: String
    var infoText: String
    var problemGenerator: ProblemGenerator
}

extension ExamDefinition: Equatable, Hashable {
    static func == (lhs: ExamDefinition, rhs: ExamDefinition) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Exam {
    var definition: ExamDefinition
    var problemDifficulty: ProblemDifficulty
    
    var workedProblems: [WorkedProblem] = []
    
    var currentProblem: Problem
    var submittedAnswer: Double? = nil
    
    init(_ definition: ExamDefinition, difficulty: ProblemDifficulty) {
        self.definition = definition
        self.problemDifficulty = difficulty
        self.currentProblem = definition.problemGenerator.generateProblem(difficulty: problemDifficulty)
    }
    
    func nextProblemAllowed() -> Bool {
        submittedAnswer == nil
    }
    
    mutating func nextProblem() -> Problem {
        //If we have an answer, we can record as a worked problem
        if let ans = submittedAnswer {
            workedProblems.append(
                .init(problem: currentProblem, answer: ans)
            )
            currentProblem = definition.problemGenerator.generateProblem(difficulty: problemDifficulty)
            submittedAnswer = nil
        }
        
        return currentProblem
    }
    
}
