//
//  ExamRegistry.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension ExamRegistry {
    
    static let testRegistry = ExamRegistry(examGroups: [
        ExamGroup.testGroup
    ])
    
}

extension ExamGroup {
    
    static let testGroup = ExamGroup(
        id: "TEST",
        name: "Test Group",
        examDefinitions: [
            TestExam.definition,
            TestExam.definition
        ]
    )
    
}
