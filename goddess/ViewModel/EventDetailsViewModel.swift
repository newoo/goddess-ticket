//
//  EventDetailsViewModel.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/16.
//

import RxSwift
import RxCocoa

final class EventDetailsViewModel {
  let eventDetailsSectionRelay: BehaviorRelay<[EventDetailsSection]>
  
  init(product: Product) {
    let items = [
      EventDetailsItem(product: product, type: .image),
      EventDetailsItem(product: product, type: .place),
      EventDetailsItem(product: product, type: .contents)
    ]
    let sections = [EventDetailsSection(type: .detail, items: items)]
    eventDetailsSectionRelay = BehaviorRelay<[EventDetailsSection]>(value: sections)
  }
}
