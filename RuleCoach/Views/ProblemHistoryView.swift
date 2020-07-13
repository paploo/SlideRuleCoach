//
//  ProblemHistoryView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/12/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ProblemHistoryView : View {
    
    var exam: Binding<Exam>
    
    var workedProblemCount: Int {
        exam.workedProblems.wrappedValue.count
    }
    
    var summaryHeader: some View {
        HStack {
            Image(systemName: "number.circle.fill")
                .foregroundColor(.blue)
                .imageScale(.large)
            Text("Exam Results Summary")
                .foregroundColor(.gray)
        }
    }
    
    var historyHeader: some View {
        HStack {
            Image(systemName: "clock.fill")
                .foregroundColor(.blue)
                .imageScale(.large)
            Text("Exam Problem History")
                .foregroundColor(.gray)
        }
    }
    
    var body: some View {
        List {
            
            Section(header: summaryHeader) {
                
                Text("Put stat summary here")
                
            }
            
            Section(header: historyHeader) {

                if self.exam.workedProblems.wrappedValue.isEmpty {
                    HStack {
                        Image(systemName: "exclamationmark.circle")
                            .foregroundColor(.gray)
                        Text("No Problems Submitted Yet")
                            .foregroundColor(.gray)
                    }
                }

                ForEach(0..<workedProblemCount) { index in
                    WorkedProblemView(
                        workedProblem: self.exam.workedProblems[(self.workedProblemCount-1) - index]
                    )
                }

            }
            
        }
        .listStyle(GroupedListStyle())
    }
    
}

//TODO: Maybe this in the flow of seeing results after submitting before next problem?
//      If that flip-flop is tricky we can also keep track of how many problems re left
//      in the test, and then show the results at the end.
//
//      Another option is to inline in the view and real-time update bound to the
//      text field, so that they can see like before. I could even make it a
//      disclosure triangle view so that they have the option of hiding it. (Note
//      that it is trivial to combine the current problem with a submitted value
//      to make a standalone worked problem to do the calculations.
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
