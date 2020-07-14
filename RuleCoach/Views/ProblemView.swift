//
//  ProblemView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/12/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ProblemView : View {
    
    var exam: Binding<Exam>
    
    @State var submittedAnswer: Double? = nil
    
    func submitAnswer() {
        exam.wrappedValue.submitAnswer(submittedAnswer: submittedAnswer ?? 0.0)
        submittedAnswer = nil
    }
    
    var body: some View {
        Form {
            
            Section(header: Text("Problem \((exam.wrappedValue.problemCount()+1).description) of \(exam.wrappedValue.maxProblemCount.description)")) {
                if(exam.currentProblem.displayType.wrappedValue == .singleLine) {
                    SimpleProblemView(problem: exam.currentProblem)
                }
                if(exam.currentProblem.displayType.wrappedValue == .fractional) {
                    FractionProblemDetail(problem: exam.currentProblem)
                }
            
            
            
            HStack {
                TextField(
                    "Answer",
                    value: $submittedAnswer,
                    formatter: NumberFormatter.decimalFormatter(),
                    onEditingChanged: { flag in
                        print("EDIT \(flag)")
                    },
                    onCommit: {
                        print("COMMIT")
                        //self.submitAnswer()
                    }
                )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numbersAndPunctuation)
//                    .padding(5.0)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10.0)
//                        .stroke(lineWidth: 1.0)
//                        .foregroundColor(.gray)
//                    )
            
            
                if(submittedAnswer == nil) {
                    Button(action: {
                        print("click")
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
            }
        }
    }
    
}

struct SimpleProblemView: View {
    
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

extension Text {
    func monospaced() -> Text {
        font(.system(.body, design: .monospaced))
    }
}

struct ProblemView_Previews: PreviewProvider {
    static var previews: some View {
        let exam = Exam(TestExamFactory.defaultDefinition(), difficulty: .normal)
        
        return Group {
            ProblemView(exam: .constant(exam))
            
            SimpleProblemView(problem: .constant(Problem(
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
        }
    }
}
