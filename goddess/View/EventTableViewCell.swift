//
//  EventTableViewCell.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/15.
//

import UIKit
import RxSwift

class EventTableViewCell: UITableViewCell {
  static let identifier = "EventTableViewCell"
  
  private let thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 10
    imageView.layer.masksToBounds = true
    imageView.backgroundColor = .lightGray
    
    return imageView
  }()
  
  private let displayNameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkGray
    label.font = .systemFont(ofSize: 14)
    
    return label
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 16)
    
    return label
  }()
  
  private let commentLabel: UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.font = .systemFont(ofSize: 12)
    label.numberOfLines = 2
    
    return label
  }()
  
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.textColor = .systemPink
    label.font = .boldSystemFont(ofSize: 18)
    
    return label
  }()
  
  private var verticalStackView: UIStackView
  
  let itemInput = PublishSubject<Product>()
  
  private var disposeBag = DisposeBag()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    let arrangedSubviews = [
      displayNameLabel, nameLabel, commentLabel, priceLabel
    ]
    verticalStackView = UIStackView(arrangedSubviews: arrangedSubviews)
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
    
    thumbnailImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(16)
      $0.width.height.equalTo(100)
    }
    
    verticalStackView.snp.makeConstraints {
      $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(16)
      $0.top.trailing.bottom.equalToSuperview().inset(16)
    }
  }
  
  private func addSubviews() {
    contentView.addSubview(thumbnailImageView)
    contentView.addSubview(verticalStackView)
  }
  
  private func setStackView() {
    verticalStackView.axis = .vertical
    verticalStackView.spacing = 2
  }
  
  private func bind() {
    itemInput.map { $0.thumbnailImageUrl }
      .observeOn(MainScheduler.instance)
      .bind(to: thumbnailImageView.rx.imageURL)
      .disposed(by: disposeBag)
    
    itemInput.map { $0.displayName }
      .observeOn(MainScheduler.instance)
      .bind(to: displayNameLabel.rx.text)
      .disposed(by: disposeBag)
    
    itemInput.map { $0.name }
      .observeOn(MainScheduler.instance)
      .bind(to: nameLabel.rx.text)
      .disposed(by: disposeBag)
    
    itemInput.map { $0.comment }
      .observeOn(MainScheduler.instance)
      .bind(to: commentLabel.rx.text)
      .disposed(by: disposeBag)
    
    itemInput.map { $0.priceText }
      .observeOn(MainScheduler.instance)
      .bind(to: priceLabel.rx.text)
      .disposed(by: disposeBag)
  }
}
