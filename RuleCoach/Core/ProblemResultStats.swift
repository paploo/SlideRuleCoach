//
//  ProblemrResultStats.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/28/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

struct ProblemResultStats {
    
    struct ResultStat {
        var expected: Double
        var given: Double
        
        func delta() -> Double { given - expected }
        func error() -> Double { expected == 0 ? 0.0 : delta() / expected }
    }
    
    var answerStat: ResultStat
    var parametereizedAnswerStat: ResultStat
    
    init(answerStat: ResultStat, parametereizedAnswerStat: ResultStat) {
        self.answerStat = answerStat
        self.parametereizedAnswerStat = parametereizedAnswerStat
    }
    
    init(expectedAnswer: Double, givenAnswer: Double, scaleParameterizer: ScaleParameterizer) {
        let ansStat = ResultStat(expected: expectedAnswer, given: givenAnswer)
        let paramStat = ResultStat(
            expected: scaleParameterizer.parameterize(value: expectedAnswer),
            given: scaleParameterizer.parameterize(value: givenAnswer)
        )
        self.init(answerStat: ansStat, parametereizedAnswerStat: paramStat)
    }
}


extension WorkedProblem {
    
    func resultStats() -> ProblemResultStats {
        return ProblemResultStats(
            expectedAnswer: problem.expectedAnswer,
            givenAnswer: submittedAnswer,
            scaleParameterizer: problem.scaleParameterizer
        )
    }
    
}

extension Exam {
    
    func averageAnswerError() -> Double {
        return workedProblems.map { $0.resultStats().answerStat.error() }.map { abs($0) }.average()
    }
    
    func averageParameterizedAnswerDelta() -> Double {
        return workedProblems.map { $0.resultStats().parametereizedAnswerStat.delta() }.map { abs($0) }.average()
    }
    
}
