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

class Exam : ObservableObject {
    var definition: ExamDefinition
    
    @Published var workedProblems: [WorkedProblem] = []
    
    @Published var currentProblem: Problem? = nil
    @Published var submittedAnswer: Double? = nil
    
    init(_ definition: ExamDefinition) {
        self.definition = definition
    }
    
    func nextProblemAllowed() -> Bool {
        submittedAnswer == nil
    }
    
    func nextProblem(difficulty: ProblemDifficulty) -> Problem {
        //Ensure we have a problem
        var prob = currentProblem ?? definition.problemGenerator.generateProblem(difficulty: difficulty)
        
        //If we have an answer, we can record as a worked problem
        if let ans = submittedAnswer {
            workedProblems.append(
                .init(problem: prob, answer: ans)
            )
            prob = definition.problemGenerator.generateProblem(difficulty: difficulty)
            submittedAnswer = nil
        }
        
        //Now we can make assignments and return.
        currentProblem = prob
        return prob
    }
    
}
