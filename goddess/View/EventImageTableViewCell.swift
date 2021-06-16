//
//  EventImageTableViewCell.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/16.
//

import UIKit
import RxSwift

class EventImageTableViewCell: UITableViewCell {
  static let identifier = "EventImageTableViewCell"
  
  private let eventImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .lightGray
    
    return imageView
  }()
  
  let itemInput = PublishSubject<EventImagePresentable>()
  
  private var disposeBag = DisposeBag()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setConstraints()
    bind()
  }
  
  private func setConstraints() {
    addSubviews()
    
    eventImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.width.height.equalTo(UIScreen.main.bounds.width)
    }
  }
  
  private func addSubviews() {
    contentView.addSubview(eventImageView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func bind() {
    itemInput.map { $0.imageUrl }
      .observeOn(MainScheduler.instance)
      .bind(to: eventImageView.rx.imageURL)
      .disposed(by: disposeBag)
  }
}
