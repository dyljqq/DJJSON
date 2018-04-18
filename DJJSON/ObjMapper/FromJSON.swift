//
//  FromJSON.swift
//  DJJSON
//
//  Created by 季勤强 on 2018/4/8.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

import Foundation

final class FromJSON {
  class func basicType<FieldType>(_ field: inout FieldType, object: FieldType?) {
    if let value = object {
      field = value
    }
  }
  
  /// handle opetional basic type
  class func optionalBasicType<FieldType>(_ left: inout FieldType?, object: FieldType?) {
    left = object
  }
  
  class func object<N: Mappable>(_ field: inout N, map: Map) {
    if let value = map.currentValue as? [String: Any], let map: N = Mapper().map(JSON: value) {
      field = map
    }
  }
  
  class func optionalObject<N: Mappable>(_ field: inout N?, map: Map) {
    if let value = map.currentValue as? [String: Any] {
      field = Mapper<N>().map(JSON: value)
    }
  }
}
