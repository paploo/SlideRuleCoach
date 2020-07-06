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
}

struct ExamRegistry {
    var examGroups: [ExamGroup]
    
    static let testRegistry = ExamRegistry(examGroups: [
        ExamGroup.testGroup
    ])
}

struct ExamGroup {
    var name: String
    var examDefinitions: [ExamDefinition]
    
    static let testGroup = ExamGroup(
        name: "Test Group",
        examDefinitions: [
            TestExam.definition,
            TestExam.definition
        ]
    )
}
