//
//  EventSection.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/15.
//

import RxDataSources

struct EventSection {
  enum SectionType: String, Comparable, CaseIterable {
    case recommend, new
    
    var headerTitle: String {
      switch self {
      case .recommend:
        return "추천이벤트"
        
      case .new:
        return "신규이벤트"
      }
    }
    
    static func < (lhs: EventSection.SectionType,
                   rhs: EventSection.SectionType) -> Bool {
      guard let leftIndex = allCases.firstIndex(of: lhs),
            let rightIndex = allCases.firstIndex(of: rhs) else {
        return false
      }
      
      return leftIndex < rightIndex
    }
  }
  
  let type: SectionType
  var items: [EventItem]
}

extension EventSection: SectionModelType {
    typealias Identity = SectionType
    typealias Item = EventItem
    
    var identity: SectionType {
        type
    }

    init(original: EventSection, items: [EventItem]) {
        self = original
        self.items = items
    }
}
