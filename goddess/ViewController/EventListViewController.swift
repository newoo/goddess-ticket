//
//  EventListViewController.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/15.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class EventListViewController: UIViewController {
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 132
    tableView.register(EventTableViewCell.self,
                       forCellReuseIdentifier: EventTableViewCell.identifier)
    
    return tableView
  }()
  
  private lazy var dataSource = RxTableViewSectionedReloadDataSource<EventSection>(
    configureCell: { [weak self] (dataSource, tableView, indexPath, item) -> UITableViewCell in
      let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell
      cell?.itemInput.onNext(item.product)
      return cell ?? UITableViewCell()
    }, titleForHeaderInSection: { dataSource, index in
      dataSource.sectionModels[index].type.headerTitle
    })
  
  private let viewModel = EventListViewModel()
  
  private var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setConstraints()
    bind()
  }
  
  private func setConstraints() {
    addSubviews()
    
    tableView.snp.makeConstraints {
      $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
      $0.bottom.equalToSuperview()
    }
  }
  
  private func addSubviews() {
    view.addSubview(tableView)
  }
  
  private func bind() {
    viewModel.eventSectionsSubject
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
}

