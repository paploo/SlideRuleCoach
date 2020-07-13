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
            
        }
        .listStyle(GroupedListStyle())
    }
    
}

struct ExamHelpView_Previews: PreviewProvider {
    static var previews: some View {
        ExamHelpView(examDefinition: TestExamFactory.defaultDefinition())
    }
}
