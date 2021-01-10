//
//  StartExamView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/12/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct StartExamView : View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    var examDefinition: ExamDefinition
    
    @Binding var currentExam: Exam?
    
    @State var selectedDifficulty: ProblemDifficulty = .normal
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Exam").bold()
                    Spacer()
                    Text(examDefinition.name)
                }
            }
            
            Section {
                VStack(alignment: .leading) {
                    Text("Problem Difficulty").bold()
                    Picker("Problem Dificulty", selection: $selectedDifficulty) {
                        ForEach(ProblemDifficulty.allCases, id: \.self){ d in
                            Text(d.rawValue).tag(d)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .labelsHidden()
                    
                }
            }
                
            Section {
            
                if(currentExam != nil) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .imageScale(.large)
                            .foregroundColor(.yellow)
                        Text("Test in Progress (\(currentExam!.definition.name)) will be stopped.")
                    }
                }
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.currentExam = Exam(
                            self.examDefinition,
                            difficulty: self.selectedDifficulty,
                            maxProblemCount: self.userSettings.examLength
                        )
                    }) {
                        Text("Start Exam")
                    }
                    
                    Spacer()
                }
                
            }
        }
    }
    
}

struct StartExamView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
        
            StartExamView(
                examDefinition: ExamDefinition.testExam(),
                currentExam: .constant(nil)
            )
            
            StartExamView(
                examDefinition: ExamDefinition.testExam(),
                currentExam: .constant(
                    Exam(
                        ExamDefinition.testExam(),
                        difficulty: .easy
                    )
                )
            )
            
        }
    }
}
