//
//  LambdaFormatter.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 9/16/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import Foundation

/**
 * Type-safe Formatter interface.
 *
 * Subclasses should override the typed `string` and `object` methods to gain new functionality.
 */
class TypedFormatter<T: AnyObject>: Formatter {
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func string(from obj: T?) -> String? {
        fatalError("Missing Implementation")
    }
    
    func object(from string: String?) -> T? {
        fatalError("Missing Implementation")
    }
    
    override func string(for obj: Any?) -> String? {
        if let o = obj as? T? {
            return string(from: o)
        } else {
            return nil
        }
    }
    
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        obj?.pointee = object(from: string) as AnyObject?
        return true
    }
    
}

class TypedNumberFormatter: TypedFormatter<NSNumber> {
    
    var sigFigs: Int = 5
    
    override func string(from obj: NSNumber?) -> String? {
        print("string from \(String(describing: obj))")
        if let n = obj {
            return String.init(format: "%0.\(sigFigs)g", n.doubleValue)
        } else {
            return nil
        }
    }
    
    override func object(from string: String?) -> NSNumber? {
        print("object from \(String(describing: string))")
        if let s = string,
           let d = Double(s) {
            return NSNumber(value: d)
        } else {
            return nil
        }
    }
    
}

/**
 * Formatter that bridges from the NSFormatter interface to a type-safe functional interface.
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

struct LambdaFormatters {
    
    static func number(sigFigs: Int) -> LambdaFormatter<NSNumber> {
        .init(
            encoder: { num in
                if let n = num {
                    return String.init(format: "%0.\(sigFigs)g", n.doubleValue)
                } else {
                    return nil
                }
            },
            decoder: { str in
                print("decoder[sigFigs: \(sigFigs)](\(str))")
                if let d = Double(str) {
                    return NSNumber(value: d)
                } else {
                    return nil
                }
            }
        )
    }
    
}
