//
//  EventPlaceTableViewCell.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/16.
//

import UIKit
import RxSwift

class EventPlaceTableViewCell: UITableViewCell {
  static let identifier = "EventPlaceTableViewCell"
  
  private let locationLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkGray
    label.font = .systemFont(ofSize: 12)
    
    return label
  }()
  
  private let customerLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    
    return label
  }()
  
  private let stackView: UIStackView
  
  let itemInput = PublishSubject<EventPlacePresentable>()
  
  private var disposeBag = DisposeBag()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    stackView = UIStackView(arrangedSubviews: [locationLabel, customerLabel])
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setConstraints()
    setStackView()
    bind()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setConstraints() {
    addSubviews()
    
    stackView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.top.bottom.equalToSuperview().inset(8)
    }
  }
  
  private func setStackView() {
    stackView.axis = .vertical
    stackView.spacing = 4
  }
  
  private func addSubviews() {
    contentView.addSubview(stackView)
  }
  
  private func bind() {
    itemInput.map { $0.locationName }
      .observeOn(MainScheduler.instance)
      .bind(to: locationLabel.rx.text)
      .disposed(by: disposeBag)
    
    itemInput.map { $0.customerName }
      .observeOn(MainScheduler.instance)
      .bind(to: customerLabel.rx.text)
      .disposed(by: disposeBag)
  }
}

