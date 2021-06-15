//
//  EventItem.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/15.
//

import RxDataSources

struct EventItem: IdentifiableType, Equatable {
  typealias Identity = String
  
  let product: Product
  
  var identity: String {
    String(product.productCode.hashValue)
  }
  
  static func == (lhs: EventItem, rhs: EventItem) -> Bool {
    return lhs.product.productCode == rhs.product.productCode
  }
}
