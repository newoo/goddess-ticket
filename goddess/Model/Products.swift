//
//  Products.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/16.
//

struct Products: Decodable {
  let recommendProducts: [Product]
  let newProducts: [Product]
  
  enum CodingKeys: String, CodingKey {
    case recommendProducts, newProducts
  }
}
