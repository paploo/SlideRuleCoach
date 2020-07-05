//
//  Proctor.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

final class Proctor: ObservableObject {
    var examRegistry: [ExamGroup: ExamDefinition] = [:]
    @Published var currentExam: Exam? = nil
}
