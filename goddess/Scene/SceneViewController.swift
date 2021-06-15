//
//  SceneViewController.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/16.
//

import UIKit

class SceneViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    SceneCoordinator.shared.setCurrentViewController(self)
  }
}
