//
//  myPageViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/05/31.
//

import Foundation
import UIKit
import SwiftUI

class myPageViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let hostingController = UIHostingController(rootView: MyPageScene())
    
    hostingController.view.frame = view.frame
    
    addChild(hostingController)
    view.addSubview(hostingController.view)
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: false)
  }
}
