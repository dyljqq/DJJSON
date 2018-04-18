//
//  SwiftyJSON.swift
//  DJJSON
//
//  Created by 季勤强 on 2018/4/10.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

import Foundation

enum Type {
  case dictionary
  case array
  case number
  case string
  case null
  case unknown
}

struct JSON {
  
  /// Constructor
  init(data: Data) throws {
    let object = try JSONSerialization.jsonObject(with: data, options: []) as Any
    self.init(jsonObject: object)
  }
  
  init(_ object: Any) {
    switch object {
    case let object as Data:
      do {
        try self.init(data: object)
      } catch {
        self.init(jsonObject: NSNull())
      }
    default:
      self.init(jsonObject: object)
    }
  }
  
  init(parseJSON jsonString: String) {
    if let data = jsonString.data(using: .utf8) {
      self.init(data)
    } else {
      self.init(jsonObject: NSNull())
    }
  }
  
  init(jsonObject: Any) {
    self.object = jsonObject
  }
  
  
  /// parse
  
  static var null: JSON = JSON(NSNull())
  
  fileprivate var rawArray: [Any] = []
  fileprivate var rawDictionary: [String: Any] = [:]
  fileprivate var rawString = ""
  fileprivate var rawNumber: NSNumber = 0
  fileprivate var rawNull = NSNull()
  
  private var type: Type = .null
  
  var object: Any {
    get {
      switch self.type {
      case .array: return self.rawArray
      case .dictionary: return self.rawDictionary
      case .string: return self.rawString
      case .number: return self.rawNumber
      default: return self.rawNull
      }
    }
    
    set {
      switch unwrap(newValue) {
      case let number as NSNumber:
        self.type = .number
        self.rawNumber = number
      case let string as String:
        self.type = .string
        self.rawString = string
      case let dict as [String: Any]:
        self.type = .dictionary
        self.rawDictionary = dict
      case let array as [Any]:
        self.type = .array
        self.rawArray = array
      default:
        self.type = .unknown
      }
    }
  }
  
  private func unwrap(_ object: Any) -> Any {
    switch object {
    case let json as JSON:
      return unwrap(json.object)
    case let dict as [String: Any]:
      var unwrappedDic = [String: Any]()
      dict.forEach { key, value in
        unwrappedDic[key] = unwrap(value)
      }
      return dict
    case let array as [Any]:
      return array.map(unwrap)
    default:
      return object
    }
  }
  
}

extension JSON {
  
  subscript(key key: String) -> JSON {
    get {
      var r: JSON = JSON.null
      if self.type == .dictionary {
        if let o = self.rawDictionary[key] {
          r = JSON(o)
        }
      }
      return r
    }
  }
  
  subscript(path: [String]) -> JSON {
    get {
      return path.reduce(self) { $0[key: $1] }
    }
    
    set {
      
    }
  }
  
  subscript(path: String...) -> JSON {
    get {
      return self[path]
    }
    
    set {
      self[path] = newValue
    }
  }
  
}

extension JSON {
  
  var numberValue: NSNumber {
    return self.rawNumber
  }
  
  var intValue: Int {
    return self.rawNumber.intValue
  }
  
  var stringValue: String {
    return self.rawString
  }
  
}
