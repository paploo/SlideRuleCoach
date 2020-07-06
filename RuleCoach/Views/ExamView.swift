//
//  ExamView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ExamView: View {
    
    @EnvironmentObject var proctor: Proctor
    
    @Binding var exam: Exam
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(exam.currentProblem?.questionText ?? "No Question")
                Text(exam.currentProblem?.expectedAnswer.description ?? "No Expected Answer")
            }
            .navigationBarTitle(Text(exam.definition.name), displayMode: .inline)
            .navigationBarItems(
                leading: Image(systemName: "info.circle"),
                trailing: Image(systemName: "gear")
            )
        }
    }
}

struct ExamView_Previews: PreviewProvider {
    
    static var previews: some View {
        let proctor = Proctor(examRegistry: ExamRegistry.testRegistry)
        
        let exam = Exam(TestExam.definition)
        proctor.currentExam = exam
        return ExamView(exam:  Binding.constant(exam))
            .environmentObject(proctor)
    }
}
