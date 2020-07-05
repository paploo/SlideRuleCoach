//
//  ContentView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/4/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var showSheet: Bool = false
    @State var selectedSheetItem: MainNavItem = .about
    
    enum MainNavItem {
        case settings, about, examInfo(exam: String) //TODO be an actual exam.
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
    
    private func examInfoButton(_ exam: String) -> some View {
        Button(action: {
            self.selectedSheetItem = MainNavItem.examInfo(exam: exam)
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
        case .examInfo(let exam):
            return Text(exam)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Group 1").bold()) {
                    Text("Alpha")
                    Text("Beta")
                }
                
                Section(header: Text("Group 2").bold()) {
                    Text("Alpha")
                    Text("Beta")
                    examInfoButton("asdf")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
