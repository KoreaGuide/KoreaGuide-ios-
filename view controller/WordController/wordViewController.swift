//
//  File.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/04/03.
//

import Foundation
import UIKit
import SwiftUI
class wordViewController: UIViewController {
  /*
  @IBSegueAction func ToWordMainView(_ coder: NSCoder) -> UIViewController? {
    return UIHostingController(coder: coder, rootView: WordMainView())
  }*/
  @IBSegueAction func ToWordMainView(_ coder: NSCoder) -> UIViewController? {
    return UIHostingController(coder: coder, rootView: WordMainView())
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()

    let swiftUIView = UIHostingController(rootView: WordMainView())
    self.present(swiftUIView, animated: true, completion: nil)
  }
}
