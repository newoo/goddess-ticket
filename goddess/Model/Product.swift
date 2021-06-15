//
//  Product.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/15.
//

struct Product: Decodable { 
  let productCode: String
  let displayName: String
  let thumbnailImageUrl: String
  let price: Int
  let name: String
  let comment: String
  let currencyName: String
  
  var priceText: String {
    let _price = Double(price) / 10000
    return (_price > 10 ? String(Int(_price)) : String(format: "%.1f", _price)) + "만원"
  }
  
  enum CodingKeys: String, CodingKey {
    case productCode, displayName, thumbnailImageUrl,
         price, name, comment, currencyName
  }
}
