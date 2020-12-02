//
//  DictionaryGenerator.swift
//  
//
//  Created by COFFEE on 2020/12/02.
//

import Foundation

@dynamicCallable
public struct DictionaryGenerator {
    public init() {}
    public func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, Any?>) -> [String:Any] {
        var dictionary:[String:Any] = [:]
        pairs.forEach { (key, value) in
            dictionary[key] = value
        }
        return dictionary
    }
}
