//
//  Map.swift
//  DJJSON
//
//  Created by 季勤强 on 2018/4/8.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

import Foundation

final class Map {
  
  var currentValue: Any?
  var JSON: [String: Any] = [:]
  
  init(JSON: [String: Any]) {
    self.JSON = JSON
  }
  
  subscript(key: String) -> Map {
    return self[key, false]
  }
  
  subscript(key: String, nested: Bool) -> Map {
    if nested {
      (_, currentValue) = valueFor(ArraySlice(key.components(separatedBy: ".")), dict: JSON)
    } else {
      let object = JSON[key]
      let isNSNull = object is NSNull
      currentValue = isNSNull ? nil : object
    }
    return self
  }
  
  func value<T>() -> T? {
    return currentValue as? T
  }
  
  // NSNULL会出现在JSON解析中
  private func valueFor(_ keyPathComponents: ArraySlice<String>, dict: [String: Any]) -> (Bool, Any?) {
    guard !keyPathComponents.isEmpty else { return (false, nil) }
    
    if let keyPath = keyPathComponents.first {
      let obj = dict[keyPath]
      if obj is NSNull {
        return (true, nil)
      } else if keyPathComponents.count > 1, let d = obj as? [String: Any] {
        let tail = keyPathComponents.dropFirst()
        return valueFor(tail, dict: d)
      } else if keyPathComponents.count > 1, let arr = obj as? [Any] {
        let tail = keyPathComponents.dropFirst()
        return valueFor(tail, array: arr)
      } else {
        return (obj != nil, obj)
      }
    }
    
    return (false, nil)
  }
  
  private func valueFor(_ keyPathComponents: ArraySlice<String>, array: [Any]) -> (Bool, Any?) {
    guard !keyPathComponents.isEmpty else { return (false, nil) }
    
    if let keyPath = keyPathComponents.first, let index = Int(keyPath), index >= 0 && index < array.count {
      let obj = array[index]
      if obj is NSNull {
        return (true, nil)
      } else if keyPathComponents.count > 1, let dict = obj as? [String: Any] {
        let tail = keyPathComponents.dropFirst()
        return valueFor(tail, dict: dict)
      } else if keyPathComponents.count > 1, let arr = obj as? [Any] {
        let tail = keyPathComponents.dropFirst()
        return valueFor(tail, array: arr)
      } else {
        return (true, obj)
      }
    }
    
    return (false, nil)
  }
  
}
