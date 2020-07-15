//
//  StartExamView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/12/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct StartExamView : View {
    
    var examDefinition: ExamDefinition
    @Binding var currentExam: Exam?
    
    @State var selectedDifficulty: ProblemDifficulty = .normal
    
    var body: some View {
        Form {
            //Text(currentExam.wrappedValue.debugDescription)
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
                    .padding()
                    .pickerStyle(WheelPickerStyle())
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
                            difficulty: self.selectedDifficulty
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
                examDefinition: TestExamFactory.defaultDefinition(),
                currentExam: .constant(nil)
            )
            
            StartExamView(
                examDefinition: TestExamFactory.defaultDefinition(),
                currentExam: .constant(
                    Exam(
                        TestExamFactory.defaultDefinition(),
                        difficulty: .easy
                    )
                )
            )
            
        }
    }
}
