//
//  SettingsView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/14/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        Form {
            
            Section(header: Text("Exam Settings")) {
                
                Toggle(isOn: $userSettings.showNotesField) {
                    Text("Show Notes Field")
                }
                
            }
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
        .environmentObject(UserSettings())
    }
}
