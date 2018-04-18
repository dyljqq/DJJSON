//
//  Ability.swift
//  DJJSON
//
//  Created by 季勤强 on 2018/4/8.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

import Foundation

enum Appraise: String {
  case excellent
  case fine
  case bad
}

struct Ability: Mappable {
  var mathematics: Appraise?
  var physics: Appraise?
  var chemistry: Appraise?
  
  init?(map: Map) {
    
  }
  
  mutating func mapping(map: Map) {
    mathematics <- map["mathematics"]
    physics <- map["physics"]
    chemistry <- map["chemistry"]
  }
}

struct GrocerProduct: Mappable {
  var name: String?
  var points: Int?
  var ability: Ability?
  var description: String?
  
  init?(map: Map) {
    
  }
  
  mutating func mapping(map: Map) {
    name <- map["name"]
    points <- map["points"]
    ability <- map["ability"]
    description <- map["description"]
  }
}
