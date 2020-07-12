//
//  Proctor.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

final class Proctor: ObservableObject {
    var examRegistry: ExamRegistry
    @Published var currentExam: Exam? = nil
    @Published var difficulty: ProblemDifficulty = .easy
    
    init(examRegistry: ExamRegistry) {
        self.examRegistry = examRegistry
    }
    
    //This gets the current exam for a given exam definition
    func currentExamFor(definition: ExamDefinition) -> Exam {
        if (currentExam?.definition != definition) {
            currentExam = Exam(definition, firstProblemDifficulty: difficulty)
        }
        return currentExam!
    }
}

struct ExamRegistry {
    var examGroups: [ExamGroup]
}

struct ExamGroup: Identifiable, Equatable, Hashable {
    var id: String
    var name: String
    var examDefinitions: [ExamDefinition]
}
