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

//TODO: Set a target length, like 20 problems? UI can choosse to enforce.
struct Exam {
    var definition: ExamDefinition
    var problemDifficulty: ProblemDifficulty
    var maxProblemCount: Int = 20
    
    var workedProblems: [WorkedProblem] = []
    
    var currentProblem: Problem
    
    init(_ definition: ExamDefinition, difficulty: ProblemDifficulty) {
        self.definition = definition
        self.problemDifficulty = difficulty
        
        currentProblem = definition.problemGenerator.generateProblem(
            difficulty: problemDifficulty
        )
    }
    
    func problemCount() -> Int {
        workedProblems.count
    }
    
    func isCompleted() -> Bool {
        problemCount() >= maxProblemCount
    }
    
    mutating func submitAnswer(submittedAnswer: Double) {
        //We don't actually enfroce the max length here.
        //UIs are free to let things go indefinitely, or stop.
        
        workedProblems.append(
            .init(problem: currentProblem, submittedAnswer: submittedAnswer)
        )
        
        currentProblem = definition.problemGenerator.generateProblem(
            difficulty: problemDifficulty
        )
    }
    
}
