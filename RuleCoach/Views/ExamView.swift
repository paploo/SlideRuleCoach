//
//  ExamView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ExamView: View {
    
    @State var examDefinition: ExamDefinition
    
    @EnvironmentObject var proctor: Proctor
    
    @State private var currentProblem: Problem? = nil
    @State var foo: Bool = false
    
    private var exam: Exam {
        let e = proctor.currentExamFor(definition: examDefinition)
        currentProblem = e.currentProblem
        return e
    }
    
    var body: some View {
        print("Draw")
        return NavigationView {
            VStack(alignment: .leading) {
                Text(foo.description) //Redraw happens only when state is used directly it seems.
                Text(exam.currentProblem.questionText ?? "No Question")
                Text(exam.currentProblem.expectedAnswer.description)
                Button(action: {
                    self.exam.submittedAnswer = 3.14
                    self.currentProblem = self.exam.nextProblem(difficulty: self.proctor.difficulty)
                    self.foo.toggle()
                    print(self.exam.currentProblem.expectedAnswer)
                    print(self.proctor.currentExam?.currentProblem.expectedAnswer ?? "No Answer")
                    print(self.currentProblem?.expectedAnswer ?? "No Answer")
                }) {
                    Text("Next Problem")
                }
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
        let exam = Exam(
            TestExamFactory.definition(name: "Test Exam", expectedAnswer: 3.0),
            firstProblemDifficulty: .easy
        )
        proctor.currentExam = exam
        
        return ExamView(examDefinition: exam.definition)
            .environmentObject(proctor)
    }
}
