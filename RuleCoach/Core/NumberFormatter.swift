//
//  NumberFormatterFactory.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/13/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

extension NumberFormatter {
    
    static let notANumber: String = "N/A"
    static let bars: String = "--"
    
    static func decimalFormatter() -> NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.notANumberSymbol = notANumber
        f.nilSymbol = bars
        return f
    }
    
    static func decimalFormatter(sigFigs: Int) -> NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.notANumberSymbol = notANumber
        f.nilSymbol = bars
        f.usesSignificantDigits = true
        f.maximumSignificantDigits = sigFigs
        return f
    }
    
    static func percentageFormatter() -> NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .percent
        f.notANumberSymbol = notANumber
        f.nilSymbol = bars
        f.usesSignificantDigits = true
        f.maximumSignificantDigits = 3
        return f
    }
    
    static func fixnumFormatter(places: Int) -> NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.notANumberSymbol = notANumber
        f.nilSymbol = bars
        f.maximumFractionDigits = places
        f.minimumFractionDigits = places
        return f
    }
    
    static func generalFormatter(sigFigs: Int) -> NumberFormatter {
        let f = GeneralNumberFormatter()
        f.minimumSignificantDigits = sigFigs
        return f
    }
    
    func string(from double: Double) -> String? {
        string(from: NSNumber(value: double))
    }
    
}

/**
 * NumberFormatter that uses a fixed set of significant figures across a wide variety of magnitudes.
 */
class GeneralNumberFormatter: NumberFormatter {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init() {
        super.init()
    }

    override func number(from: String) -> NSNumber? {
        if let d = Double(from) {
            return NSNumber(value: d)
        } else {
            return nil
        }
    }
    
    override func string(from: NSNumber) -> String? {
        return String.init(format: "%0.\(minimumSignificantDigits)g", from.doubleValue)
    }
    
}
