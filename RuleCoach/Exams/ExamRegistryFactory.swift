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
        ExamGroup.basicArithmeticGroup,
        ExamGroup.testGroup
    ])
    
}

extension ExamGroup {
    
    static let basicArithmeticGroup = ExamGroup(
        id: "BASIC_ARITHMETIC",
        name: "Basic Arithmetic",
        examDefinitions: [
            ExamDefinition.multiplicationExam(),
            ExamDefinition.inversionExam()
        ]
    )
    
    static let testGroup = ExamGroup(
        id: "TEST",
        name: "Test Group",
        examDefinitions: [
            ExamDefinition.testExam(name: "Alpha", expectedAnswer: 10.0),
            ExamDefinition.testExam(name: "Beta", expectedAnswer: 100.0)
        ]
    )
    
}
