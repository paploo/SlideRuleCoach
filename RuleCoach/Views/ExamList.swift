//
//  ExamList.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ExamList: View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    @State var examRegistry: ExamRegistry
    
    @State var currentExam: Exam? = nil
    
    @State var showSheet: Bool = false
    @State var selectedSheetItem: MainSheetView.SheetContents = .about
    
    private var settingsButton: some View {
        Button(action: {
            self.selectedSheetItem = MainSheetView.SheetContents.settings
            self.showSheet.toggle()
        } ) {
            Image(systemName: "gear")
                .imageScale(.large)
        }
    }
    
    private var aboutButton: some View {
        Button(action: {
            self.selectedSheetItem = MainSheetView.SheetContents.about
            self.showSheet.toggle()
        } ) {
            Image(systemName: "info.circle")
                .imageScale(.large)
        }
    }
    
    //TODO: Should probably ectract into it a view class.
    private func examRow(_ examDefinition: ExamDefinition) -> some View {
        HStack {
            NavigationLink(
                destination: ExamView(
                    selectedExamDefinition: examDefinition,
                    currentExam: $currentExam
                ).environmentObject(self.userSettings)
            ) {
                VStack(alignment: .leading) {
                    Text(examDefinition.name)
                    Text(examDefinition.descriptionText)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .layoutPriority(1.0) //Makes sure the VStack is rendered to its full width before drawing the stopwatch. TODO: Maybe should really be using a geometry object?
                
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
                MainSheetView(selectedSheetItem: self.$selectedSheetItem)
                    .environmentObject(self.userSettings)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct MainSheetView: View {
    
    @EnvironmentObject var settings: UserSettings
    
    @Binding var selectedSheetItem: SheetContents
    
    enum SheetContents {
        case settings, about
    }
    
    var body: some View {
        Group {
            if selectedSheetItem == .settings {
                SettingsView()
            }
            if selectedSheetItem == .about {
                AboutView()
            }
        }
    }
    
}

struct ExamList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExamList(examRegistry: ExamRegistry.testRegistry)
                .environmentObject(UserSettings())
            
            ExamList(examRegistry: ExamRegistry.examRegistry)
                .environmentObject(UserSettings())
        }
    }
}
