//
//  ProblemView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/12/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ProblemView : View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    var exam: Binding<Exam>
    
    @State var submittedAnswer: Double? = nil
    
    @State var notes: String? = nil
    
    var nonOptionalNotesBinding: Binding<String> {
        Binding(
            get: {
                self.notes ?? ""
            },
            set: { s in
                self.notes = s
            }
        )
    }
    
    func submitAnswer() {
        exam.wrappedValue.submitAnswer(submittedAnswer: submittedAnswer ?? 0.0)
        submittedAnswer = nil
        notes = nil
    }
    
    var body: some View {
        VStack {
            
            Group {
                if(exam.wrappedValue.isCompleted()) {
                    ExamCompleteProblemDetail(problem: exam.currentProblem)
                }
                if(exam.currentProblem.displayType.wrappedValue == .singleLine && !exam.wrappedValue.isCompleted()) {
                    SimpleProblemDetail(problem: exam.currentProblem)
                }
                if(exam.currentProblem.displayType.wrappedValue == .fractional && !exam.wrappedValue.isCompleted()) {
                    FractionProblemDetail(problem: exam.currentProblem)
                }
            }
            .frame(height: 100.0)
            
            HStack {
                TextField(
                    "Answer",
                    value: $submittedAnswer,
                    formatter: NumberFormatter.decimalFormatter()
                )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numbersAndPunctuation)
         
                if(submittedAnswer == nil || exam.wrappedValue.isCompleted()) {
                    Button(action: {
                        //Do nothing
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.gray)
                    }
                } else {
                    Button(action: {
                        self.submitAnswer()
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .imageScale(.large)
                    }
                }
            }
            
            if(userSettings.showNotesField) {
                TextField("Notes", text: nonOptionalNotesBinding)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numbersAndPunctuation)
            }
        
        }
    }
    
}

struct SimpleProblemDetail: View {
    
    var problem: Binding<Problem>
    
    var body: some View {
        Text(problem.questionText.wrappedValue ?? "Missing Question Text")
        .monospaced()
    }
    
}

struct FractionProblemDetail: View {
    
    var problem: Binding<Problem>
    
    var body: some View {
        VStack {
            Text(self.problem.questionNumeratorText.wrappedValue ?? "Missing Question Text")
                .monospaced()
            Image(systemName: "square.fill")
                .resizable()
                .frame(height: 2.0)
            Text(self.problem.questionDenominatorText.wrappedValue ?? "Missing Question Text")
                .monospaced()
        }.fixedSize()
    }
    
}

struct ExamCompleteProblemDetail: View {
    
    var problem: Binding<Problem>
    
    var body: some View {
        HStack {
            Image(systemName: "hexagon.fill")
                .foregroundColor(.yellow)
            Text("Exam completed!")
                .bold()
        }
    }
    
}

extension Text {
    func monospaced() -> Text {
        font(.system(.body, design: .monospaced))
    }
}

struct ProblemView_Previews: PreviewProvider {
    static var previews: some View {
        let exam = Exam(TestExamFactory.defaultDefinition(), difficulty: .normal)
        
        var completedExam = exam
        completedExam.maxProblemCount = 1
        completedExam.submitAnswer(submittedAnswer: 3.14)
        
        return Group {
            ProblemView(exam: .constant(exam))
            
            ProblemView(exam: .constant(completedExam))
            
            SimpleProblemDetail(problem: .constant(Problem(
                expectedAnswer: 3.14,
                questionText: "31 x 2",
                scaleParameterizer: UnityScaleParameterizer()
            )))
            
            FractionProblemDetail(problem: .constant(Problem(
                expectedAnswer: 3.14,
                questionNumeratorText: "31 x 2",
                questionDenominatorText: "88 x 22",
                scaleParameterizer: UnityScaleParameterizer()
            )))
        }.environmentObject(UserSettings())
    }
}
