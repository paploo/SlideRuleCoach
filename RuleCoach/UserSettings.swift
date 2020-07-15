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
        case examLength = "examLength"
    }
    
    private var defaults: UserDefaults
    
    @Published var showNotesField: Bool {
        didSet {
            defaults.set(showNotesField, forKey: Key.showNotesField.rawValue)
            print("set showNotesField to \(showNotesField)")
        }
    }
    
    @Published var examLength: Int {
        didSet {
            defaults.set(examLength, forKey: Key.examLength.rawValue)
            print("set examLength to \(examLength)")
        }
    }
    
    init() {
        self.defaults = UserDefaults.standard
        
        self.showNotesField = defaults.bool(forKey: Key.showNotesField.rawValue)
        self.examLength = defaults.integer(forKey: Key.examLength.rawValue)
        
        print("showNotesField init to \(showNotesField)")
        print("examLength init to \(examLength)")
    }
    
}
