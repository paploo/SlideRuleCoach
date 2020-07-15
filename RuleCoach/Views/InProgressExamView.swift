//
//  InProgressExamView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/14/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct InProgressExamView: View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    var exam: Binding<Exam>
    
    var problemHeader: some View {
        var labelText = ""
        if exam.wrappedValue.isCompleted() {
            let count = exam.wrappedValue.problemCount()
            labelText = "Completed \(count) Problems"
        } else {
            //We offset by 1, because the currrent problem is not in the worked problems
            let currProblemNumber = exam.wrappedValue.problemCount() + 1
            let maxProblemNumber = exam.maxProblemCount.wrappedValue
            labelText = "Problem \(currProblemNumber) of \(maxProblemNumber)"
        }
        return HStack {
            Image(systemName: "pencil.circle.fill")
                .foregroundColor(.blue)
                .imageScale(.large)
            Text(labelText)
        }
    }
    
    var statsHeader: some View {
        HStack {
            Image(systemName: "number.circle.fill")
                .foregroundColor(.blue)
                .imageScale(.large)
            Text("Exam Results Summary")
        }
    }
    
    var historyHeader: some View {
        HStack {
            Image(systemName: "clock.fill")
                .foregroundColor(.blue)
                .imageScale(.large)
            Text("Exam Problem History")
        }
    }
    
    var body: some View {
        Form {
            
            Section(header: problemHeader) {
                ProblemView(exam: exam)
                    .environmentObject(userSettings)
            }
            
            Section(header: statsHeader) {
               Text("TODO")
            }
            
            Section(header: historyHeader) {
                ProblemHistoryView(exam: exam)
            }
            
        }.listStyle(GroupedListStyle())
    }
    
}

struct InProgressExamView_Previews: PreviewProvider {
    static var previews: some View {
        let exam = Exam(TestExamFactory.defaultDefinition(), difficulty: .normal)
        
        return InProgressExamView(exam: .constant(exam))
            .environmentObject(UserSettings())
    }
}
