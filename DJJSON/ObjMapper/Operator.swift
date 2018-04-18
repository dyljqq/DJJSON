//
//  Operator.swift
//  DJJSON
//
//  Created by 季勤强 on 2018/4/8.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

import Foundation

infix operator <-

func <- <T>(left: inout T, right: Map) {
  FromJSON.basicType(&left, object: right.value())
}

func <- <T: Mappable>(left: inout T?, right: Map) {
  FromJSON.optionalObject(&left, map: right)
}

