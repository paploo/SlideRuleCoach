//
//  ProblemHistoryView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/12/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ProblemHistoryView : View {
    
    @Binding var exam: Exam
    
    var workedProblemCount: Int {
        exam.workedProblems.count
    }
    
    var body: some View {
        List {
            
            if self.exam.workedProblems.isEmpty {
                HStack {
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(.gray)
                    Text("No Problems Submitted Yet")
                        .foregroundColor(.gray)
                }
            }
            
            ForEach(0..<workedProblemCount, id: \.self) { index in
                WorkedProblemView(
                    workedProblem: self.$exam.workedProblems[(self.workedProblemCount-1) - index]
                )
            }
            
        }
    }
    
}

struct WorkedProblemView : View {
    
    var workedProblem: Binding<WorkedProblem>
    
    func formElem<V: View>(_ label: String, body: () -> V) -> some View {
        HStack {
            Text(label).bold()
            Spacer()
            body()
        }
    }
    
    var body: some View {
        VStack {
            formElem("Expected") {
                Text(workedProblem.problem.expectedAnswer.wrappedValue.description)
                
            }
            
            formElem("Submitted") {
                Text(workedProblem.submittedAnswer.wrappedValue.description)
            }
        }
    }
    
}

struct ProblemHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let newExam = Exam(TestExamFactory.defaultDefinition(), difficulty: .easy)
        
        var exam = newExam //Copy
        exam.submitAnswer(submittedAnswer: 2e99)
        exam.submitAnswer(submittedAnswer: 3.14)
        
        let workedProblem = WorkedProblem(
            problem: exam.currentProblem,
            submittedAnswer: 3.214
        )
        
        return Group {
            ProblemHistoryView(exam: .constant(exam))
            
            ProblemHistoryView(exam: .constant(newExam))
            
            WorkedProblemView(workedProblem: .constant(workedProblem))
        }
    }
}
