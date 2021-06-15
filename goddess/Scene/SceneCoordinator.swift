//
//  SceneCoordinator.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/16.
//


import UIKit

class SceneCoordinator {
  private var currentViewController: UIViewController?
  
  static let shared = SceneCoordinator()
  
  private init() {
    currentViewController = nil
  }
  
  func setCurrentViewController(_ viewController: UIViewController?) {
    currentViewController = viewController
  }
  
  func push(scene: Scene) {
    let nextViewController = scene.viewController
    currentViewController?.navigationController?.pushViewController(nextViewController,
                                                                    animated: true)
    setCurrentViewController(nextViewController)
  }
}
