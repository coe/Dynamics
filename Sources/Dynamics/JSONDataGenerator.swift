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
        let generator = DictionaryGenerator()
        let dictionary = generator.dynamicallyCall(withKeywordArguments: pairs)
        guard JSONSerialization.isValidJSONObject(dictionary) else {
            return nil
        }
        return try! JSONSerialization.data(withJSONObject: dictionary, options: [])
    }
}
