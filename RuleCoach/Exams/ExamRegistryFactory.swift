//
//  ExamRegistry.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension ExamRegistry {
    
    static let examRegistry = ExamRegistry(examGroups: [
        ExamGroup.basicArithmeticGroup,
        ExamGroup.squaresCubesAndRoots,
        ExamGroup.exponentsAndLogs,
        ExamGroup.trigonometry
    ])
    
    static let testRegistry = ExamRegistry(examGroups: [
        ExamGroup.testGroup
    ])
    
}

extension ExamGroup {
    
    static let basicArithmeticGroup = ExamGroup(
        id: "BASIC_ARITHMETIC",
        name: "Basic Arithmetic",
        examDefinitions: [
            ExamDefinition.multiplicationExam(),
            ExamDefinition.inversionExam(),
            ExamDefinition.compoundFractionsExam()
        ]
    )
    
    static let squaresCubesAndRoots = ExamGroup(
        id: "SQUARES_CUBES_AND_ROOTS",
        name: "Squares, Cubes, and Roots",
        examDefinitions: [
            ExamDefinition.squaresExam(),
            ExamDefinition.squareRoots(),
            ExamDefinition.cubesExam(),
            ExamDefinition.cubeRoots()
        ]
    )
    
    static let exponentsAndLogs = ExamGroup(
        id: "EXPONENTS_AND_LOGS",
        name: "Exponents & Logs",
        examDefinitions: [
            ExamDefinition.commonExponents(),
            ExamDefinition.commonLog(),
            ExamDefinition.naturalExponents()
            // Natural Exp [[new]] -- Straight LL
            // Natural Log [[new]] - Straight LL
            // Exponents (of arbitrary base)
            // Logarithms (of arbitrary base)
        ]
    )
    
    static let trigonometry = ExamGroup(
        id: "TRIG",
        name: "Trigonometric Functions",
        examDefinitions: [
            // Angle Conversion (to/from rads)
            // Arc Minute Conversion (to/from arc minutes)
            // Basic Trig Functions (sin/cos/tan)
            // Basic Inverse Trig Functions (arcsin/arcos/arctan)
            // Inverted Trug Functions (sec/csc/cot) [[new]]
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
