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
    
    /// Root method for converting a nullable object of type `T` into a nullable `String`.
    ///
    /// Subclasses **must** override this method.
    /// - Parameter obj: An object of type `T` to format as a string, or possibly `nil`
    /// - Returns: The formatted string, or `nil` if appropriate.
    func string(from obj: T?) -> String? {
        fatalError("Missing Implementation")
    }
    
    /// Root method for parsing a `String` into an object of type `T`.
    ///
    /// Subclasses **must** override this method.
    /// - Parameter string: A string to format into an object of type `T`, or `nil` if parsing fails.
    /// - Returns: An instance of type `T`, or `nil` if parsing fails.
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
        obj?.pointee = object(from: string)
        return true
    }
    
}

/// Instance of TypedFormatter that may be instantiated for injected with lambdas for the implementation.
class LambdaFormatter<T: AnyObject>: TypedFormatter<T> {
    
    init(encoder: @escaping (T?) -> String?, decoder: @escaping (String?) -> T?) {
        super.init()
        self.encoder = encoder
        self.decoder = decoder
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var encoder: ((T?) -> String?)? = nil
    
    var decoder: ((String?) -> T?)? = nil
    
    override func string(from obj: T?) -> String? {
        if let enc = encoder {
            return enc(obj)
        } else {
            return nil
        }
    }
    
    override func object(from string: String?) -> T? {
        if let dec = decoder {
            return dec(string)
        } else {
            return nil
        }
    }
    
}

/**
 * Example TypedFormatter that consumes and produces NSNumber instances wrapping doubles.
 */
class TypedNumberFormatter: TypedFormatter<NSNumber> {
    
    var sigFigs: Int = 5
    
    override func string(from obj: NSNumber?) -> String? {
        if let n = obj {
            return String.init(format: "%0.\(sigFigs)g", n.doubleValue)
        } else {
            return nil
        }
    }
    
    override func object(from string: String?) -> NSNumber? {
        if let s = string,
           let d = Double(s) {
            return NSNumber(value: d)
        } else {
            return nil
        }
    }
    
}

/**
 * Example constructors of LambdaFormatters.
 */
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
                if let s = str,
                   let d = Double(s) {
                    return NSNumber(value: d)
                } else {
                    return nil
                }
            }
        )
    }
    
}
