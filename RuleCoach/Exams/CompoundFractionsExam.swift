//
//  CompoundFractionsExam.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 8/23/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension ExamDefinition {
    
    static func compoundFractionsExam() -> ExamDefinition {
        .init(id: "COMPOUND_FRACTIONS",
              name: "Compound Fractions",
              descriptionText: "Fractions of multiple numerator/denominator terms",
              infoText: """
Slide the first denominator value on C over the first numerator value on D; move the cursor over the next numerator on C.

If there are no denominators, read answer on D, otherwise slide denominator on C under the cursor;
If there are more numerators, read the answer on D under the index on C, otherwise repeat cursor move.
""",
              problemGenerator: CompoundFractionsExamGenearator()
        )
    }
    
}

class CompoundFractionsExamGenearator: ProblemGenerator {
    
    private let scaleParameterizer: ScaleParameterizer = Log10ScaleParameterizer()
    
    private let multiplicationExamProblemGenerator: MultiplicationExamProblemGenerator = MultiplicationExamProblemGenerator()
    
    func generateProblem(difficulty: ProblemDifficulty) -> Problem {
        let numeratorProb = multiplicationExamProblemGenerator.generateProblem(difficulty: difficulty)
        let denominatorProb = multiplicationExamProblemGenerator.generateProblem(difficulty: difficulty)
        
        return Problem(
            expectedAnswer: numeratorProb.expectedAnswer / denominatorProb.expectedAnswer,
            questionNumeratorText: numeratorProb.questionText ?? "--",
            questionDenominatorText: denominatorProb.questionText ?? "--",
            scaleParameterizer: scaleParameterizer
        )
    }
    
}
