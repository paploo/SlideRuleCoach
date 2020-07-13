//
//  ExamView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ExamView: View {
    
    //This is the exam definition selected for the view.
    var selectedExamDefinition: ExamDefinition
    
    //This is a binding to the current exam.
    var currentExam: Binding<Exam?>
    
    @State var showSheet: Bool = false

    func navBarItems() -> some View {
        Button(action: {self.showSheet.toggle()}) {
            Image(systemName: "info.circle").imageScale(.large)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if currentExam.wrappedValue == nil || (currentExam.wrappedValue?.definition != selectedExamDefinition){
                StartExamView(examDefinition: selectedExamDefinition, currentExam: currentExam)
            } else {
                TabView {
                    ProblemView(exam: Binding(currentExam)!).tabItem {
                        Image(systemName: "square.and.pencil").imageScale(.large)
                        Text("Problem")
                    }
                    
                    ProblemHistoryView(exam: Binding(currentExam)!).tabItem {
                        Image(systemName: "clock").imageScale(.large)
                        Text("History")
                    }
                }.animation(nil)
            }
        }
        .navigationBarTitle(Text(selectedExamDefinition.name), displayMode: .inline)
        .navigationBarItems(trailing: navBarItems())
        .sheet(isPresented: $showSheet) {
            ExamHelpView(examDefinition: self.selectedExamDefinition)
        }
    }
}

struct ExamHelpView : View {
    var examDefinition: ExamDefinition
    
    var body: some View {
        VStack {
            Text(self.examDefinition.infoText)
        }
    }
    
}

struct StartExamView : View {
    
    var examDefinition: ExamDefinition
    var currentExam: Binding<Exam?>
    
    var body: some View {
        VStack {
            Text(currentExam.wrappedValue.debugDescription)
            Button(action: {
                self.currentExam.wrappedValue = Exam(self.examDefinition, difficulty: .easy)
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

struct ProblemHistoryView : View {
    
    var exam: Binding<Exam>
    
    var body: some View {
        List {
            Text("a")
            Text("b")
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
                ExamView(
                    selectedExamDefinition: examDef,
                    currentExam: .constant(nil)
                )
            }
            
            NavigationView {
                ExamView(
                    selectedExamDefinition: examDef,
                    currentExam: .constant(exam)
                )
            }
            
            NavigationView {
                ExamView(
                    selectedExamDefinition: TestExamFactory.definition(name: "Test Exam 2", expectedAnswer: 100.0),
                    currentExam: .constant(exam))
            }
        }
    }
}
