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
    
    //TODO: Figure out why this doesn't work with TextField elements.
    static func generalFormatter(sigFigs: Int) -> NumberFormatter {
        return LambdaNumberFormatter(
            encoder: {n in
                //TODO: depending on the size, we may want to format differently.
                String.init(format: "%0.\(sigFigs)g", n.doubleValue)
            },
            decoder: {s in
                if let d = Double(s) {
                    print(s)
                    print(d)
                    return NSNumber(value: d)
                } else {
                    return nil
                }
            }
        )
    }
    
    func string(from double: Double) -> String? {
        string(from: NSNumber(value: double))
    }
    
}

class LambdaNumberFormatter: NumberFormatter {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init() {
        super.init()
    }
    
    init(encoder: @escaping (NSNumber) -> String?, decoder: @escaping (String) -> NSNumber?) {
        super.init()
        self.encoder = encoder
        self.decoder = decoder
    }
    
    var encoder: ((NSNumber) -> String?)? = nil
    var decoder: ((String) -> NSNumber?)? = nil
    
    override func number(from: String) -> NSNumber? {
        if let dec = decoder {
            return dec(from)
        } else {
            return nil
        }
    }
    
    override func string(from: NSNumber) -> String? {
        if let enc = encoder {
            return enc(from)
        } else {
            return nil
        }
    }
    
}

/**
 * Formatter that bridges from the NSFormatter interface to a type-safe interface.
 */
class LambdaFormatter<T: AnyObject>: Formatter {
    
    override init() {
        super.init()
    }
    
    init(encoder: @escaping (T?) -> String?, decoder: @escaping (String) -> T?) {
        super.init()
        self.encoder = encoder
        self.decoder = decoder
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var encoder: ((T?) -> String?)? = nil
    
    var decoder: ((String) -> T?)? = nil
    
    func string(from obj: T?) -> String? {
        string(for: obj)
    }
    
    func object(from string: String?) -> T? {
        if let s = string {
            var obj: AnyObject? = nil
            let _ = getObjectValue(&obj, for: s, errorDescription: nil)
            return obj as? T
        } else {
            return nil
        }
    }
    
    override func string(for obj: Any?) -> String? {
        if let o = obj as? T {
            return encode(o)
        } else {
            return nil
        }
    }
    
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        obj?.pointee = decode(string) as AnyObject?
        return true
    }
    
    private func encode(_ obj: T?) -> String? {
        if let enc = encoder {
            return enc(obj)
        } else {
           return  nil
        }
    }
    
    private func decode(_ string: String) -> T? {
        if let dec = decoder {
            return dec(string)
        } else {
            return nil
        }
    }
    
}
