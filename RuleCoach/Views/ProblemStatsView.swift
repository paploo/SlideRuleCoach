//
//  ProblemStatsView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 8/18/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ProblemStatsView: View {
    
    @Binding var exam: Exam
    
    func averageError() -> String? {
        NumberFormatter.percentageFormatter().string(
            from: exam.averageAnswerError()
        )
    }
    
    func averageDelta() -> String? {
        NumberFormatter.fixnumFormatter(places: 4).string(
            from: exam.averageParameterizedAnswerDelta()
        )
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Average Absolute Error").bold()
                Spacer()
                Text(averageError() ?? "--")
            }
            
            HStack {
                Text("Average Absolute 𝝙𝘶").bold()
                Spacer()
                Text(averageDelta() ?? "--")
            }
            
        }
    }
}

struct ProblemStatsView_Previews: PreviewProvider {
    static var previews: some View {
        let newExam = Exam(TestExamFactory.defaultDefinition(), difficulty: .easy)
        
        var exam = newExam //Copy
        exam.submitAnswer(submittedAnswer: 11880)
        exam.submitAnswer(submittedAnswer: 2.131)
        
        return ProblemStatsView(exam: .constant(exam))
    }
}
