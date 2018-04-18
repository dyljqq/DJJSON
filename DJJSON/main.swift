//
//  main.swift
//  DJJSON
//
//  Created by 季勤强 on 2018/4/8.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

import Foundation

let json = """
{
"name": "Durian",
"points": 600,
"ability": {
"mathematics": "excellent",
"physics": "bad",
"chemistry": "fine"
},
"description": "A fruit with a distinctive scent."
}
"""

if let product = Mapper<GrocerProduct>().map(JSONString: json) {
  print("product: \(product.ability?.chemistry)")
}

let p = JSON(parseJSON: json)
print("value: \(p["description"].stringValue)")
