//
//  Mappable.swift
//  DJJSON
//
//  Created by 季勤强 on 2018/4/8.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

import Foundation

protocol Mappable {
  init?(map: Map)
  mutating func mapping(map: Map)
}
