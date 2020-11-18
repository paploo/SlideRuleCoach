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
    
    @Binding var exam: Exam
    
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
        exam.submitAnswer(submittedAnswer: submittedAnswer ?? 0.0)
        submittedAnswer = nil
        notes = nil
    }
    
    var body: some View {
        VStack {
            
            GeometryReader { geo in
                ScrollView(.horizontal, showsIndicators: false) {
                    Group {
                        if self.exam.isCompleted() {
                            ExamCompleteProblemDetail(problem: self.$exam.currentProblem)
                        } else {
                            ProblemDetail(questionText: self.$exam.currentProblem.questionText)
                        }
                    }
                    .frame(minWidth: geo.size.width, minHeight: 100.0, alignment: .center)
                }
            }.frame(height: 100.0)
            
            HStack {
                TextField(
                    "Answer",
                    value: $submittedAnswer,
                    formatter: NumberFormatter.generalFormatter(sigFigs: 4)
                )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numbersAndPunctuation)
         
                if(submittedAnswer == nil || exam.isCompleted()) {
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

struct ProblemDetail: View {
    
    @Binding var questionText: QuestionText
    
    var body: some View {
        switch(questionText) {
        case .singleLine(let text):
            SimpleProblemDetail(questionText: .constant(text))
        case .fractional(let num, let denom):
            FractionProblemDetail(questionNumeratorText: .constant(num), questionDenominatorText: .constant(denom))
        case .exponential(let base, let exp):
            ExponentialProblemDetail(questionBaseLineText: .constant(base), questionExponentText: .constant(exp))
        case .logarithmic(let base, let arg):
            LogarithmicProblemDetail(questionBaseText: .constant(base), questionArgumentText: .constant(arg))
        }
    }
    
}

struct SimpleProblemDetail: View {
    
    @Binding var questionText: String
    
    var body: some View {
        Text(questionText)
            .monospaced()
    }
    
}

struct FractionProblemDetail: View {
    
    @Binding var questionNumeratorText: String
    @Binding var questionDenominatorText: String
    
    var body: some View {
        VStack {
            Text(questionNumeratorText)
                .monospaced()
            Image(systemName: "square.fill")
                .resizable()
                .frame(height: 2.0)
            Text(questionDenominatorText)
                .monospaced()
        }.fixedSize()
    }
    
}

struct ExponentialProblemDetail: View {
    
    @Binding var questionBaseLineText: String
    @Binding var questionExponentText: String
    
    var body: some View {
        Text(questionBaseLineText)
            .monospaced()
            
        + Text(" ") +
            
        Text(questionExponentText)
            .monospacedSmall()
            .baselineOffset(6.0)
    }
    
}

struct LogarithmicProblemDetail: View {
    
    @Binding var questionBaseText: String
    @Binding var questionArgumentText: String
    
    var body: some View {
        Text(MathSymbols.log)
            + Text(questionBaseText).monospacedSmall().baselineOffset(-6.0)
            + Text(MathSymbols.leftParen)
            + Text(questionArgumentText).monospaced()
            + Text(MathSymbols.rightParen)
    }
    
}

struct ExamCompleteProblemDetail: View {
    
    @Binding var problem: Problem
    
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
    
    func monospacedSmall() -> Text {
        font(.system(.footnote, design: .monospaced))
    }
}

struct ProblemView_Previews: PreviewProvider {
    static var previews: some View {
        let exam = Exam(ExamDefinition.testExam(), difficulty: .normal)
        
        var completedExam = exam
        completedExam.maxProblemCount = 1
        completedExam.submitAnswer(submittedAnswer: 3.14)
        
        return Group {
            ProblemView(exam: .constant(exam))
            
            ProblemView(exam: .constant(completedExam))
            
            SimpleProblemDetail(questionText: .constant("31 x 2"))

            FractionProblemDetail(
                questionNumeratorText: .constant("31 x 2"),
                questionDenominatorText: .constant("88 x 22")
            )
            
            ExponentialProblemDetail(
                questionBaseLineText: .constant("1.2 x 34.101"),
                questionExponentText: .constant("22.30")
            )
            
            LogarithmicProblemDetail(
                questionBaseText: .constant("34.101"),
                questionArgumentText: .constant("22.30")
            )
        }.environmentObject(UserSettings())
    }
}
