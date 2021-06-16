//
//  EventContentsTableViewCell.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/16.
//

import UIKit
import RxSwift

class EventContentsTableViewCell: UITableViewCell {
  static let identifier = "EventContentsTableViewCell"
  
  private let commentLabel: UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.font = .systemFont(ofSize: 12)
    
    return label
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14)
    
    return label
  }()
  
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.textColor = .systemPink
    label.font = .boldSystemFont(ofSize: 24)
    
    return label
  }()
  
  private let stackView: UIStackView
  
  let itemInput = PublishSubject<EventContentsPresentable>()
  
  private var disposeBag = DisposeBag()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    stackView = UIStackView(arrangedSubviews: [commentLabel, nameLabel, priceLabel])
    
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
      $0.top.equalToSuperview().inset(8)
      $0.bottom.equalToSuperview().inset(16)
    }
  }
  
  private func setStackView() {
    stackView.axis = .vertical
    stackView.spacing = 4
    stackView.setCustomSpacing(16, after: nameLabel)
  }
  
  private func addSubviews() {
    contentView.addSubview(stackView)
  }
  
  private func bind() {
    itemInput.map { $0.comment }
      .observeOn(MainScheduler.instance)
      .bind(to: commentLabel.rx.text)
      .disposed(by: disposeBag)
    
    itemInput.map { $0.name }
      .observeOn(MainScheduler.instance)
      .bind(to: nameLabel.rx.text)
      .disposed(by: disposeBag)
    
    itemInput.map { $0.priceText }
      .observeOn(MainScheduler.instance)
      .bind(to: priceLabel.rx.text)
      .disposed(by: disposeBag)
  }

}
