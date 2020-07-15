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
    
    var examLengths: [Int] {
        var set: Set<Int> = [10, 20, 30, 40, 50]
        set.insert(userSettings.examLength)
        return set.sorted()
    }
    
    var body: some View {
        Form {
            
            Section(header: Text("Exam Settings")) {
                
                Toggle(isOn: $userSettings.showNotesField) {
                    Text("Show Notes Field")
                }
                
                VStack(alignment: .leading) {
                    Text("Exam Length")
                    Picker("Exam Length", selection: $userSettings.examLength) {
                        ForEach(examLengths, id: \.self) { len in
                            Text(len.description).tag(len)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .labelsHidden()
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
