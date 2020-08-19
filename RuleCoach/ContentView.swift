//
//  ContentView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/4/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var exam: Exam? = nil
    
    var examDefinition: ExamDefinition
    
    var body: some View {
        //ExamList(examRegistry: ExamRegistry.testRegistry)
        
        NavigationView {
            NavigationLink(destination:
                    Text("asdf")
                        .navigationBarTitle(Text("Title"))
                .navigationBarItems(trailing: Text("M"))
            ) { Text("Foo") }
            .navigationBarTitle(Text("Title"))
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(examDefinition: ExamDefinition.testExam())
    }
}
