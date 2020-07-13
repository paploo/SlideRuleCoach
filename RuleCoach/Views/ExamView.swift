//
//  ExamView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ExamView: View {
    
    //This is the exam definition selected for the view
    var examDefinition: ExamDefinition
    
    //This is a binding to the current exam.
    var examBinding: Binding<Exam?>

    func barItems() -> some View {
        HStack {
            Image(systemName: "info.circle").imageScale(.large)
            Image(systemName: "clock").imageScale(.large)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if examBinding.wrappedValue == nil || (examBinding.wrappedValue?.definition != examDefinition){
                StartExamView(examDefinition: examDefinition, exam: examBinding)
            } else {
                ProblemView(exam: Binding(examBinding)!)
            }
        }
        .navigationBarTitle(Text(examDefinition.name), displayMode: .inline)
        .navigationBarItems(trailing: barItems())
    }
}

struct StartExamView : View {
    var examDefinition: ExamDefinition
    var exam: Binding<Exam?>
    
    var body: some View {
        VStack {
            Text(exam.wrappedValue.debugDescription)
            Button(action: {
                self.exam.wrappedValue = Exam(self.examDefinition, difficulty: .easy)
            }) { Text("Start") }
        }
    }
}

struct ProblemView : View {
    var exam: Binding<Exam>
    
    var body: some View {
        VStack {
            Text("Problem")
            Text(exam.currentProblem.wrappedValue.questionText ?? "No Numerator")
            //Text(exam.wrappedValue)
            //Text(exam.currentProblem.expectedAnswer)
            Text(exam.currentProblem.expectedAnswer.wrappedValue.description)
            Text(exam.submittedAnswer.wrappedValue?.description ?? "None")
            Button(action: {
                self.exam.submittedAnswer.wrappedValue = Double.random(in: 0.0..<10.0)
                let p = self.exam.wrappedValue.nextProblem()
                print(p)
                print(self.exam)
            }) {
                Text("Submit")
            }
        }
    }
}

struct ExamView_Previews: PreviewProvider {
    
    static var previews: some View {
        let examDef = TestExamFactory.definition(name: "Test Exam", expectedAnswer: 10.0)
        let exam = Exam(
            examDef,
            difficulty: .easy
        )
        
        return Group {
            NavigationView {
                ExamView(examDefinition: examDef, examBinding: .constant(nil))
            }
            
            NavigationView {
                ExamView(
                    examDefinition: examDef,
                    examBinding: .constant(exam)
                )
            }
            
            NavigationView {
                ExamView(
                    examDefinition: TestExamFactory.definition(name: "Test Exam 2", expectedAnswer: 100.0),
                    examBinding: .constant(exam))
            }
        }
    }
}
