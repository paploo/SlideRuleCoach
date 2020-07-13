//
//  Proctor.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

struct ExamRegistry {
    var examGroups: [ExamGroup]
}

struct ExamGroup: Identifiable, Equatable, Hashable {
    var id: String
    var name: String
    var examDefinitions: [ExamDefinition]
}
