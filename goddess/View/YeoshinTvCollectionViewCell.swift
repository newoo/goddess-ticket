//
//  YeoshinTvCollectionViewCell.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/17.
//

import UIKit
import RxSwift

class YeoshinTvCollectionViewCell: UICollectionViewCell {
  static let identifier = "YeoshinTvCollectionViewCell"
  
  private let thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 10
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    
    return imageView
  }()
  
  private let nameLabel = UILabel()
  
  let itemInput = PublishSubject<YeoshinTv>()
  
  var disposeBag = DisposeBag()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setConstraints()
    bind()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setConstraints() {
    addSubviews()
    
    thumbnailImageView.snp.makeConstraints {
      $0.leading.top.trailing.equalToSuperview().inset(4)
      $0.width.equalTo(160)
      $0.height.equalTo(90)
    }
    
    nameLabel.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview().inset(4)
      $0.top.equalTo(thumbnailImageView.snp.bottom).offset(2)
    }
  }
  
  private func addSubviews() {
    contentView.addSubview(thumbnailImageView)
    contentView.addSubview(nameLabel)
  }
  
  private func bind() {
    itemInput.map { $0.thumbnailUrl }
      .observeOn(MainScheduler.instance)
      .bind(to: thumbnailImageView.rx.imageURL)
      .disposed(by: disposeBag)
    
    itemInput.map { $0.tvNameMain }
      .observeOn(MainScheduler.instance)
      .bind(to: nameLabel.rx.text)
      .disposed(by: disposeBag)
  }
}
