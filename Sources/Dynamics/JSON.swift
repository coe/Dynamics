//
//  JSON.swift
//
//
//  Created by COFFEE on 2020/11/29.
//

import Foundation

@dynamicMemberLookup
public enum JSON {
    case dictionaryValue(Dictionary<String, JSON>)
    case arrayValue(Array<JSON>)
    case numberValue(NSNumber)
    case stringValue(String)
    case boolValue(Bool)
    case nullValue
    
    public var stringValue: String? {
        if case .stringValue(let str) = self {
            return str
        }
        return nil
    }
    
    public var numberValue: NSNumber? {
        if case .numberValue(let number) = self {
            return number
        } else if case .boolValue(let b) = self {
            return NSNumber(value: b)
        }
        return nil
    }
    
    public var boolValue: Bool? {
        if case .boolValue(let bool) = self {
            return bool
        }
        return nil
    }
    
    public var nullValue: NSNull? {
        if case .nullValue = self {
            return NSNull()
        }
        return nil
    }
    
    public subscript(index: Int) -> JSON? {
        if case .arrayValue(let array) = self {
            return index < array.count ? array[index] : nil
        }
        return nil
    }
    
    public subscript(dynamicMember member: String) -> JSON? {
        if case .dictionaryValue(let dict) = self {
            return dict[member]
        }
        return nil
    }
    
    private init(_ object: Any) {
        switch object {
        case let boolValue as Bool: self = .boolValue(boolValue)
        case let numberValue as NSNumber: self = .numberValue(numberValue)
        case let stringValue as String: self = .stringValue(stringValue)
        case let dictionaryValue as Dictionary<String, Any>: self = JSON.dictionaryValue(dictionaryValue.mapValues{ JSON($0) })
        case let arrayValue as Array<Any>: self = .arrayValue(arrayValue.map { JSON($0)} )
        default: self = .nullValue
        }
    }
    
    public init(data: Data) throws {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        self = .init(jsonObject)
    }
}
