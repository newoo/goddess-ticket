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

class EventListViewController: SceneViewController {
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
  
  private let viewModel: EventListViewModel
  
  private var disposeBag = DisposeBag()
  
  init(viewModel: EventListViewModel = .init()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    self.viewModel = .init()
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "이벤트"
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
    
    tableView.rx.itemSelected
      .subscribe(onNext: { [weak self] indexPath in
        guard let product = self?.dataSource.sectionModels[indexPath.section].items[indexPath.row].product else {
          return
        }
        let eventDetailsViewModel = EventDetailsViewModel(product: product)
        SceneCoordinator.shared.push(scene: .eventDetailsView(eventDetailsViewModel))
      }).disposed(by: disposeBag)
  }
}

