//
//  ProblemView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/12/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ProblemView : View {
    
    var exam: Binding<Exam>
    
    @State var submittedAnswer: Double? = nil
    
    var inputNumberFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumSignificantDigits = 6
        return nf
    }
    
    var body: some View {
        VStack {
            Text("Problem")
            Text(exam.problemDifficulty.wrappedValue.rawValue)
            Text(exam.currentProblem.wrappedValue.questionText ?? "No Numerator")
            //Text(exam.wrappedValue)
            //Text(exam.currentProblem.expectedAnswer)
            Text(exam.currentProblem.expectedAnswer.wrappedValue.description)
            //Text(exam.submittedAnswer.wrappedValue?.description ?? "None")
            Text(submittedAnswer?.description ?? "None")
            
            TextField("Answer", value: $submittedAnswer, formatter: inputNumberFormatter)
            
            if(submittedAnswer == nil) {
                Button(action: {}) {
                    Text("Submit Answer")
                        .foregroundColor(.gray)
                }
            } else {
                Button(action: {
                    self.exam.wrappedValue.submitAnswer(submittedAnswer: self.submittedAnswer ?? 0.0)
                    self.submittedAnswer = nil
                }) {
                    Text("Submit Answer")
                }
            }
            
        }
    }
    
}

struct ProblemView_Previews: PreviewProvider {
    static var previews: some View {
        let exam = Exam(TestExamFactory.defaultDefinition(), difficulty: .normal)
        return ProblemView(exam: .constant(exam))
    }
}
