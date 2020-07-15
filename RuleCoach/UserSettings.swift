//
//  UserSettings.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/14/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

class UserSettings: ObservableObject {
    
    private enum Key: String {
        case showNotesField = "showNotesField"
    }
    
    @Published var showNotesField: Bool {
        didSet {
            UserDefaults.standard.set(showNotesField, forKey: Key.showNotesField.rawValue)
        }
    }
    
    init() {
        self.showNotesField = UserDefaults.standard.bool(forKey: Key.showNotesField.rawValue)
    }
    
}
