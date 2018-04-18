//
//  Mapper.swift
//  DJJSON
//
//  Created by 季勤强 on 2018/4/8.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

import Foundation

final class Mapper<M: Mappable> {
  
  func map(JSONString: String) -> M? {
    if let JSON = Mapper.parseJSONString(JSONString: JSONString) as? [String: Any] {
      return map(JSON: JSON)
    }
    return nil
  }
  
  func map(JSON: [String: Any]) -> M? {
    let map = Map(JSON: JSON)
    if let klass = M.self as? Mappable.Type {
      if var obj = klass.init(map: map) as? M {
        obj.mapping(map: map)
        return obj
      }
    }
    return nil
  }
  
  static func parseJSONString(JSONString: String) -> Any? {
    // 转换过程中是否允许字符进行必要的删减或者替换
    if let data = JSONString.data(using: String.Encoding.utf8, allowLossyConversion: true) {
      do {
        return try JSONSerialization.jsonObject(with: data, options: .allowFragments)
      } catch let error {
        print("parse error: \(error)")
        return nil
      }
    }
    return nil
  }
  
}
