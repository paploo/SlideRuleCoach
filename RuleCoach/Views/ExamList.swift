//
//  ExamList.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ExamList: View {
    
    @State var examRegistry: ExamRegistry
    
    //@State var currentExamDefinition: ExamDefinition? = nil
    @State var currentExam: Exam? = nil
    
    @State var showSheet: Bool = false
    @State var selectedSheetItem: MainNavItem = .about
    
    enum MainNavItem {
        case settings, about
    }
    
    private var settingsButton: some View {
        Button(action: {
            self.selectedSheetItem = MainNavItem.settings
            self.showSheet.toggle()
        } ) {
            Image(systemName: "gear")
                .imageScale(.large)
        }
    }
    
    private var aboutButton: some View {
        Button(action: {
            self.selectedSheetItem = MainNavItem.about
            self.showSheet.toggle()
        } ) {
            Image(systemName: "info.circle")
                .imageScale(.large)
        }
    }

    
    private var sheetContents: some View {
        switch self.selectedSheetItem {
        case .settings:
            return Text("Settings")
        case .about:
            return Text("About")
        }
    }
    
    //TODO: Maybe just make this go to the exam definition;
    //let that class lazily create the exam for the definition if
    //none exists already (removing an old one if it isn't right)
    private func examRow(_ examDefinition: ExamDefinition) -> some View {
        HStack {
            NavigationLink(
                destination: ExamView(
                    selectedExamDefinition: examDefinition,
                    currentExam: $currentExam
                )
            ) {
                VStack(alignment: .leading) {
                    Text(examDefinition.name)
                    Text(examDefinition.descriptionText)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                if(examDefinition == currentExam?.definition) {
                    Image(systemName: "stopwatch")
                        .foregroundColor(.blue)
                }
            }
        }
        
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(examRegistry.examGroups) { group in
                    Section(header: Text(group.name).font(.headline)) {
                        ForEach(group.examDefinitions) { def in
                            self.examRow(def)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Exams"))
            .navigationBarItems(leading: aboutButton, trailing: settingsButton)
            .sheet(isPresented: $showSheet) {
                //TODO: Make this do something.
                self.sheetContents
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct ExamList_Previews: PreviewProvider {
    static var previews: some View {
        ExamList(examRegistry: ExamRegistry.testRegistry)
    }
}
