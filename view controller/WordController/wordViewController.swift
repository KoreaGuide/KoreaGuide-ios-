//
//  File.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/04/03.
//

import Foundation
import SwiftUI
import UIKit
class wordViewController: UIViewController {
  /*
   @IBSegueAction func ToWordMainView(_ coder: NSCoder) -> UIViewController? {
     return UIHostingController(coder: coder, rootView: WordMainView())
   }*/

  override func viewDidLoad() {
    super.viewDidLoad()

    // let swiftUIView = UIHostingController(rootView: WordMainView())

    let hostingController = UIHostingController(rootView: WordMainScene())
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    hostingController.view.frame = view.bounds

    addChild(hostingController)
    view.addSubview(hostingController.view)
  }
}
