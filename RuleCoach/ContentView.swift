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
    @State var selectedMainNavItem: MainNavItem = .about
    
//    private var prefsButton: some View {
//        Button(action: { self.showSettings.toggle()} ) {
//        Image(systemName: "gear")
//            .imageScale(.large)
//            .padding()
//        }
//    }
//
//    private var helpButton: some View {
//        Button(action: { self.showHelp.toggle()} ) {
//        Image(systemName: "questionmark.circle")
//            .imageScale(.large)
//            .padding()
//        }
//    }
    
    private var sheetContents: some View {
        switch self.selectedMainNavItem {
        case .settings:
            return Text("Settings")
        case .about:
            return Text("About")
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
                    Image(systemName: "info.circle")
                    Image(systemName: "questionmark.circle")
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Exams"))
            .navigationBarItems(trailing:
                MainNavItemButtons(
                    showSheet: $showSheet,
                    selectedMainNavItem: $selectedMainNavItem
                )
            )
//            .navigationBarItems(trailing: helpButton)
//                .sheet(isPresented: $showHelp) {
//                    Text("Help")
//                }
//            .navigationBarItems(trailing: prefsButton)
            .sheet(isPresented: $showSheet) {
                self.sheetContents
            }
        }
    }
    
}

struct MainNavItemButtons: View {
    
    @Binding var showSheet: Bool
    @Binding var selectedMainNavItem: MainNavItem
    
    private var settingsButton: some View {
        Button(action: {
            self.selectedMainNavItem = MainNavItem.settings
            self.showSheet.toggle()
        } ) {
        Image(systemName: "gear")
            .imageScale(.large)
        }
    }
    
    private var aboutButton: some View {
        Button(action: {
            self.selectedMainNavItem = MainNavItem.about
            self.showSheet.toggle()
        } ) {
        Image(systemName: "questionmark.circle")
            .imageScale(.large)
        }
    }
    
    var body: some View {
        HStack() {
            aboutButton
            Spacer().frame(width: 20.0)
            settingsButton
        }.padding()
    }
    
}

enum MainNavItem {
    case settings, about
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
