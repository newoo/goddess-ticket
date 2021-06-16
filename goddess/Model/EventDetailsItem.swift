//
//  EventDetailsItem.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/16.
//

import RxDataSources

struct EventDetailsItem: IdentifiableType, Equatable {
  typealias Identity = String
  
  enum ItemType: String {
    case image, place, contents
  }
  
  let product: Product
  let type: ItemType
  
  var identity: String {
    String(product.productCode.hashValue ^ type.hashValue)
  }
  
  static func == (lhs: EventDetailsItem, rhs: EventDetailsItem) -> Bool {
    return lhs.product.productCode == rhs.product.productCode
  }
}

extension EventDetailsItem: EventImagePresentable {
  var imageUrl: String {
    product.thumbnailImageUrl.components(separatedBy: "?").first ?? ""
  }
}

extension EventDetailsItem: EventPlacePresentable {
  var locationName: String {
    product.locationName
  }
  
  var customerName: String {
    product.customerName
  }
}

extension EventDetailsItem: EventContentsPresentable {
  var comment: String {
    product.comment
  }
  
  var name: String {
    product.name
  }
  
  var priceText: String {
    product.price.decimalText + "원"
  }
}
