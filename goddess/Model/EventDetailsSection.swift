//
//  EventDetailsSection.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/16.
//

import RxDataSources

struct EventDetailsSection {
  enum SectionType: String, Comparable, CaseIterable {
    case detail
    
    var headerTitle: String {
      switch self {
      case .detail:
        return "추천이벤트"
      }
    }
    
    static func < (lhs: EventDetailsSection.SectionType,
                   rhs: EventDetailsSection.SectionType) -> Bool {
      guard let leftIndex = allCases.firstIndex(of: lhs),
            let rightIndex = allCases.firstIndex(of: rhs) else {
        return false
      }
      
      return leftIndex < rightIndex
    }
  }
  
  let type: SectionType
  var items: [EventDetailsItem]
}

extension EventDetailsSection: SectionModelType {
    typealias Identity = SectionType
    typealias Item = EventDetailsItem
    
    var identity: SectionType {
        type
    }

    init(original: EventDetailsSection, items: [EventDetailsItem]) {
        self = original
        self.items = items
    }
}
