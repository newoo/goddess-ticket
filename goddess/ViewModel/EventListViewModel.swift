//
//  EventListViewModel.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/15.
//

import RxSwift
import RxCocoa
import Moya

final class EventListViewModel {
  let eventSectionsSubject = BehaviorSubject<[EventSection]>(value: [])
  
  private var disposeBag = DisposeBag()
  
  init() {
    bind()
  }
  
  private func bind() {
    let productProvider = MoyaProvider<ProductAPI>()
    
    productProvider.rx.request(.fetchList)
      .map(ProductsResponse.self)
      .map { response -> [EventSection] in
        let recommendItems = response.results.recommendProducts.map { EventItem(product: $0) }
        let newItems = response.results.newProducts.map { EventItem(product: $0) }
        
        return [EventSection(type: .recommend, items: recommendItems),
        EventSection(type: .new, items: newItems)]
      }.asObservable()
      .bind(to: eventSectionsSubject)
      .disposed(by: disposeBag)
  }
}
