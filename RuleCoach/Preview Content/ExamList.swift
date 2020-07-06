//
//  ExamList.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/5/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ExamList: View {
    
    @EnvironmentObject var proctor: Proctor
    
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
    
    private func examRow(_ examDefinition: ExamDefinition) -> some View {
        HStack {
            NavigationLink(destination: Text("Detail: \(examDefinition.name)")) {
                VStack(alignment: .leading) {
                    Text(examDefinition.name)
                    Text(examDefinition.descriptionText)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                if(examDefinition != proctor.currentExam?.definition) {
                    Image(systemName: "stopwatch")
                        .foregroundColor(.blue)
                }
            }
        }
        
    }
    
    var x: Int { proctor.examRegistry.examGroups.count }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(proctor.examRegistry.examGroups, id: \.name) { group in
                    Section(header: Text(group.name).font(.headline)) {
                        ForEach(group.examDefinitions) { def in
                            //Text(def.name)
                            self.examRow(def)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Exams"))
            .navigationBarItems(leading: aboutButton, trailing: settingsButton)
            .sheet(isPresented: $showSheet) {
                self.sheetContents
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct ExamList_Previews: PreviewProvider {
    static var previews: some View {
        ExamList()
            .environmentObject(Proctor(examRegistry: ExamRegistry.testRegistry))
    }
}
