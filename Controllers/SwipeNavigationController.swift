//
//  SwipeNavigationController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/15.
//

import UIKit

class SwipeNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    override init(nibName nibNameorNil: String?, bundle nibBundleorNil: Bundle?) {
        super.init(nibName: nibNameorNil, bundle: nibBundleorNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }

    private func setup() {
      delegate = self
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      // This needs to be in here, not in init
      interactivePopGestureRecognizer?.delegate = self
    }

    deinit {
      delegate = nil
      interactivePopGestureRecognizer?.delegate = nil
    }

    // MARK: - Overrides

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
      duringPushAnimation = true
      super.pushViewController(viewController, animated: animated)
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
      // 뷰 스택에 있는 vc 갯수가 1개이거나 0개이면 백드래그 액션 안되게 막아둠.
      if viewControllers.count > 1 {
        interactivePopGestureRecognizer?.isEnabled = true
      } else {
        interactivePopGestureRecognizer?.isEnabled = false
      }
    }

    // MARK: - Private Properties

    fileprivate var duringPushAnimation = false
    
}
