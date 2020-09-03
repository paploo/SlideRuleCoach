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
        let (numCount, denomCount) = termCount(difficulty: difficulty)
        let numeratorTerms = generateTermValues(termCount: numCount, difficulty: difficulty)
        let denominatorTerms = generateTermValues(termCount: denomCount, difficulty: difficulty)
        
        return Problem(
            expectedAnswer: numeratorTerms.product() / denominatorTerms.product(),
            questionText: .fractional(
                numerator: numeratorTerms.joinWithFormatter(separator: MathSymbols.times.padded(with: " ")),
                denominator: denominatorTerms.joinWithFormatter(separator: MathSymbols.times.padded(with: " "))
            ),
            scaleParameterizer: scaleParameterizer
        )
        
    }
    
    private func generateTermValues(termCount: Int, difficulty: ProblemDifficulty) -> [Double] {
        (0 ..< termCount).map { _ in value(difficulty: difficulty) }
    }
    
    private func termCount(difficulty: ProblemDifficulty) -> (Int, Int) {
        switch difficulty {
        case .introductory:
            return (2,2)
        case .easy:
            return safeTermCount(minTerms: 2, maxTerms: 4)
        case .normal:
            return safeTermCount(minTerms: 2, maxTerms: 4)
        case .advanced:
            return (Int.random(in: 2 ... 4), Int.random(in: 2 ... 4))
        case .master:
            return (Int.random(in: 2 ... 4), Int.random(in: 2 ... 4))
        }
    }
    
    /**
     * Generate numerator and denominator terms in the range and separated by no more than the max delta.
     *
     * The classic procedure requires the numerator and denominator term counts
     * to be within one of eachother. But we also want to not have the min
     * or max for either be too big. So we compensate.
     */
    private func safeTermCount(minTerms: Int, maxTerms: Int) -> (Int, Int) {
        let a = Int.random(in: minTerms ... maxTerms)
        
        switch a {
        case minTerms:
            return (a, Int.random(in: a ... a+1))
        case maxTerms:
            return (a, Int.random(in: a-1 ... a))
        default:
            return (a, Int.random(in: a-1 ... a+1))
        }
    }
    
    private func value(difficulty: ProblemDifficulty) -> Double {
        switch difficulty {
        case .introductory:
            return scaleParameterizer.randomScaleValue(inU: 0.0 ..< 1.0)
        case .easy:
            return scaleParameterizer.randomScaleValue(inU: 0.0 ..< 1.0)
        case .normal:
            return scaleParameterizer.randomScaleValue(inU: -2.0 ..< 2.0)
        case .advanced:
            return scaleParameterizer.randomScaleValue(inU: -3.0 ..< 3.0)
        case .master:
            return scaleParameterizer.randomScaleValue(inU: -6.0 ..< 6.0)
        }
    }
    
}
