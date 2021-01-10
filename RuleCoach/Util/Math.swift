//
//  Math.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 8/26/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation
import Darwin

extension Double {
    
    static var e: Double = Darwin.M_E
    
}

extension Bool {
    
    func signDoubleValue() -> Double {
        self ? 1.0 : -1.0
    }
    
}
