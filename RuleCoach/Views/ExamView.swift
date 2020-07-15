//
//  ExamView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ExamView: View {
    
    @EnvironmentObject var userSettings: UserSettings
    
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
                    .environmentObject(self.userSettings)
            } else {
                InProgressExamView(exam: Binding(currentExam)!)
                    .environmentObject(self.userSettings)
            }
        }
        .navigationBarTitle(Text(selectedExamDefinition.name), displayMode: .inline)
        .navigationBarItems(trailing: navBarItems())
        .sheet(isPresented: $showSheet) {
            ExamHelpView(examDefinition: self.selectedExamDefinition)
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
        }.environmentObject(UserSettings())
    }
}
