//
//  UITextFieldExtension.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/04/03.
//

import Foundation
import UIKit

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x:0,y:0, width:10,height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
