//
//  myPageViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/05/31.
//

import Foundation
import UIKit
import SwiftUI

class myPageViewController: ViewController {
  @IBSegueAction func ToMyPageScene(_ coder: NSCoder) -> UIViewController? {
    return UIHostingController(coder: coder, rootView: MyPageScene())
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    let hostingController = UIHostingController(rootView: MyPageScene())
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    hostingController.view.frame = view.bounds
    addChild(hostingController)
    view.addSubview(hostingController.view)
  }
}
