//
//  Products.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/16.
//

struct Products: Decodable {
  let yeoshinTv: [YeoshinTv]
  let recommendProducts: [Product]
  let newProducts: [Product]
  
  enum CodingKeys: String, CodingKey {
    case yeoshinTv, recommendProducts, newProducts
  }
}
