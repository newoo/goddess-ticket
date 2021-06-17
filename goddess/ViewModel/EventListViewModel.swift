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
  let eventSectionsOutput = BehaviorSubject<[EventSection]>(value: [])
  let yeoshinTvsOutput = BehaviorSubject<[YeoshinTv]>(value: [])
  
  private var disposeBag = DisposeBag()
  
  init() {
    bind()
  }
  
  private func bind() {
    let productProvider = MoyaProvider<ProductAPI>()
    
    productProvider.rx.request(.fetchList)
      .map(ProductsResponse.self)
      .asObservable()
      .subscribe(onNext: { [weak self] response in
        let yeoshinTvs = response.results.yeoshinTv
        let recommendItems = response.results.recommendProducts.map { EventItem(product: $0) }
        let newItems = response.results.newProducts.map { EventItem(product: $0) }
        
        self?.yeoshinTvsOutput.onNext(yeoshinTvs)
        self?.eventSectionsOutput.onNext([EventSection(type: .recommend, items: recommendItems),
                                          EventSection(type: .new, items: newItems)])
        
      }).disposed(by: disposeBag)
  }
}
