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
            Section(header: historyHeader) {
                Text("a")
                Text("b")
            }
        }
        .listStyle(GroupedListStyle())
    }
    
}

struct ProblemHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let exam = Exam(TestExamFactory.defaultDefinition(), difficulty: .easy)
        return ProblemHistoryView(exam: Binding.constant(exam))
    }
}
