//
//  ExamHelpView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/12/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ExamHelpView : View {
    
    var examDefinition: ExamDefinition
    
    var infoHeader: some View {
         HStack {
             Image(systemName: "info.circle.fill")
                 .foregroundColor(.blue)
                 .imageScale(.large)
             Text("Exam Information")
                 .foregroundColor(.gray)
         }
    }
    
    var helpHeader: some View {
         HStack {
             Image(systemName: "questionmark.circle.fill")
                 .foregroundColor(.gray)
                 .imageScale(.large)
             Text("Exam Help")
                 .foregroundColor(.gray)
         }
    }
    
    var resultHelpHeader: some View {
        HStack {
            Image(systemName: "questionmark.circle.fill")
                .foregroundColor(.gray)
                .imageScale(.large)
            Text("Results Help")
                .foregroundColor(.gray)
        }
    }
    
    var body: some View {
        List {
            Section(header: infoHeader) {
                        
                VStack(alignment: .leading) {
                    Text(self.examDefinition.name)
                        .font(.title)
                    
                    Text(self.examDefinition.descriptionText)
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                
            }
            
            Section(header: helpHeader) {
                ScrollView {
                    Text(self.examDefinition.infoText)
                }
            }
            
            Section(header: resultHelpHeader) {
                ScrollView {
                    Text(ExamHelpView.resultHelpText)
                }
            }
            
        }
        .listStyle(GroupedListStyle())
    }
    
}

struct ExamHelpView_Previews: PreviewProvider {
    static var previews: some View {
        ExamHelpView(examDefinition: ExamDefinition.testExam())
    }
}

extension ExamHelpView {
    static var resultHelpText: String = """
Results may be expressed both as an actual answer, and in the parameterized variable 𝘶, which is expressed as the fraction of the distance across the slide rule's scale (i.e. a value from 0.0 to 1.0).

For slide-rules with an L scale (log base 10), the cursor location on the L scale corresponds to the 𝘶-value of the cursor.

Given this definition, the difference in the parameterized given answer from the parameterized actual answer tells one the physical distance of tick-marks from their correct position.

For a typical 25 cm (10") slide-rule, 𝝙𝘶 = 0.0010 corresponds to a 0.25mm (1/100") error in reading.
"""
}
