//
//  JSONDataGenerator.swift
//  
//
//  Created by COFFEE on 2020/11/29.
//

import Foundation

@dynamicCallable
public struct JSONDataGenerator {
    public init() {}
    public func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, Any?>) -> Data? {
        var dictionary:[String:Any] = [:]
        pairs.forEach { (key, value) in
            dictionary[key] = value
        }
        guard JSONSerialization.isValidJSONObject(dictionary) else {
            return nil
        }
        return try! JSONSerialization.data(withJSONObject: dictionary, options: [])
    }
}
