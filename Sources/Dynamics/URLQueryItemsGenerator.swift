//
//  URLQueryItemsGenerator.swift
//  
//
//  Created by COFFEE on 2020/11/29.
//

import Foundation

@dynamicCallable
public struct URLQueryItemsGenerator {
    public init() {}
    public func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, String?>) -> [URLQueryItem] {
        pairs.map { (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        }
    }
}
