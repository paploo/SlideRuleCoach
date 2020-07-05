//
//  Exam.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

struct ExamGroup : Equatable, Hashable {
    var name: String
}

struct ExamDefinition {
    var name: String
    var description: String
    var infoText: String
    var problemGenerator: ProblemGenerator
}

class Exam : ObservableObject {
    var definition: ExamDefinition
    var difficulty: ProblemDifficulty
    
    @Published var workedProblems: [WorkedProblem] = []
    
    @Published var currentProblem: Problem
    @Published var submittedAnswer: Double? = nil
    
    init(definition: ExamDefinition, difficulty: ProblemDifficulty) {
        self.definition = definition
        self.difficulty = difficulty
        
        //Set first problem.
        currentProblem = definition.problemGenerator.generateProblem(difficulty: difficulty)
    }
    
    func nextProblemAllowed() -> Bool {
        submittedAnswer == nil
    }
    
    func nextProblem() -> Problem {
        if let currAns = submittedAnswer {
            //If we have an answer, put into the history and advance the problem,
            workedProblems.append(WorkedProblem(problem: currentProblem, answer: currAns))
            submittedAnswer = nil
            currentProblem = definition.problemGenerator.generateProblem(difficulty: difficulty)
        } else {
            //Else, don't let them advance.
        }
        return currentProblem
    }
    
}
