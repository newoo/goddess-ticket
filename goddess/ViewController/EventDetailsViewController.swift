//
//  EventDetailsViewController.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/16.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class EventDetailsViewController: SceneViewController {
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(EventImageTableViewCell.self,
                       forCellReuseIdentifier: EventImageTableViewCell.identifier)
    tableView.register(EventPlaceTableViewCell.self,
                       forCellReuseIdentifier: EventPlaceTableViewCell.identifier)
    tableView.register(EventContentsTableViewCell.self,
                       forCellReuseIdentifier: EventContentsTableViewCell.identifier)
    
    return tableView
  }()
  
  private lazy var dataSource = RxTableViewSectionedReloadDataSource<EventDetailsSection>(
    configureCell: { [weak self] (dataSource, tableView, indexPath, item) -> UITableViewCell in
      let item = dataSource.sectionModels[indexPath.section].items[indexPath.row]
      
      switch item.type {
      case .image:
        let cell = tableView.dequeueReusableCell(withIdentifier: EventImageTableViewCell.identifier, for: indexPath) as? EventImageTableViewCell
        cell?.itemInput.onNext(item)
        return cell ?? UITableViewCell()
        
      case .place:
        let cell = tableView.dequeueReusableCell(withIdentifier: EventPlaceTableViewCell.identifier, for: indexPath) as? EventPlaceTableViewCell
        cell?.itemInput.onNext(item)
        return cell ?? UITableViewCell()
        
      case .contents:
        let cell = tableView.dequeueReusableCell(withIdentifier: EventContentsTableViewCell.identifier, for: indexPath) as? EventContentsTableViewCell
        cell?.itemInput.onNext(item)
        return cell ?? UITableViewCell()
      }
    })
  
  private let viewModel: EventDetailsViewModel
  
  private var disposeBag = DisposeBag()
  
  init(viewModel: EventDetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setConstraints()
    bind()
  }
  
  private func setConstraints() {
    addSubview()
    
    tableView.snp.makeConstraints {
      $0.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
      $0.width.height.equalTo(UIScreen.main.bounds.width)
    }
  }
  
  private func addSubview() {
    view.addSubview(tableView)
  }
  
  private func bind() {
    viewModel.eventDetailsSectionRelay
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
}
