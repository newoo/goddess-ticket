//
//  Scene.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/16.
//

import UIKit

enum Scene {
  case eventListView(EventListViewModel)
  case eventDetailsView(EventDetailsViewModel)
}

extension Scene {
  var viewController: UIViewController {
    switch self {
    case let .eventListView(viewModel):
      let viewController = EventListViewController()
      return viewController
      
    case let .eventDetailsView(viewModel):
      let viewController = EventDetailsViewController(viewModel: viewModel)
      return viewController
    }
  }
}
