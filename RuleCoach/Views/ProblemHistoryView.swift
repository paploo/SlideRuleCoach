//
//  ProblemHistoryView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/12/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ProblemHistoryView : View {
    
    @Binding var exam: Exam
    
    var workedProblemCount: Int {
        exam.workedProblems.count
    }
    
    var body: some View {
        List {
            
            if self.exam.workedProblems.isEmpty {
                HStack {
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(.gray)
                    Text("No Problems Submitted Yet")
                        .foregroundColor(.gray)
                }
            }
            
            ForEach(0..<workedProblemCount, id: \.self) { index in
                WorkedProblemView(
                    workedProblem: self.$exam.workedProblems[(self.workedProblemCount-1) - index]
                )
            }
            
        }
    }
    
}

struct WorkedProblemView : View {
    
    @Binding var workedProblem: WorkedProblem
    
    func expected() -> String? {
        NumberFormatter.decimalFormatter(sigFigs: 5).string(from: workedProblem.resultStats().answerStat.expected
        )
    }
    
    func submitted() -> String? {
        NumberFormatter.decimalFormatter(sigFigs: 5).string(from: workedProblem.resultStats().answerStat.given
        )
    }
    
    func error() -> String? {
        NumberFormatter.percentageFormatter().string(
            from: workedProblem.resultStats().answerStat.error()
        )
    }
    
    func delta() -> String? {
        NumberFormatter.fixnumFormatter(places: 4).string(
            from: workedProblem.resultStats().parametereizedAnswerStat.delta()
        )
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("Submitted").bold()
                Spacer()
                Text(submitted() ?? "--")
            }
            
            HStack {
                Text("Expected").bold()
                Spacer()
                Text(expected() ?? "--")
            }
            
            HStack {
                Text("Error").bold()
                Spacer()
                Text(error() ?? "--")
            }
            
            HStack {
                Text("𝝙𝘶").bold()
                Spacer()
                Text(delta() ?? "--")
            }
            
        }
    }
    
}

struct ProblemHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let newExam = Exam(ExamDefinition.testExam(), difficulty: .easy)
        
        var exam = newExam //Copy
        exam.submitAnswer(submittedAnswer: 11880)
        exam.submitAnswer(submittedAnswer: 2.131)
        
        let workedProblem = WorkedProblem(
            problem: exam.currentProblem,
            submittedAnswer: 28.214000000001
        )
        
        return Group {
            ProblemHistoryView(exam: .constant(exam))
            
            ProblemHistoryView(exam: .constant(newExam))
            
            WorkedProblemView(workedProblem: .constant(workedProblem))
        }
    }
}
