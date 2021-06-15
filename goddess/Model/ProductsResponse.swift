//
//  ProductsResponse.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/15.
//

struct ProductsResponse: Decodable {
  let results: Products
  
  enum CodingKeys: String, CodingKey {
    case results
  }
}
