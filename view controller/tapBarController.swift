//
//  tapBarController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/04/03.
//

import Foundation
import UIKit
import SwiftUI

//탭바가 있는 모든 vc는 이 클래스를 상속받는다.
class TabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  @IBSegueAction func ToWordMainView(_ coder: NSCoder) -> UIViewController? {
    return UIHostingController(coder: coder, rootView: WordMainView())
  }
  @IBAction func didTabButton(_ sender: Any)
  {
    guard let first = storyboard?.instantiateViewController(withIdentifier: "?") else {return}
    
      guard let second = storyboard?.instantiateViewController(withIdentifier: "?") else {return}
    
      guard let third = storyboard?.instantiateViewController(withIdentifier: "?") else {return}
    
      guard let fourth = storyboard?.instantiateViewController(withIdentifier: "?") else {return}
    
    let tb = UITabBarController()
    tb.setViewControllers([first,second,third,fourth], animated: true)
    present(tb,animated:true,completion: nil)
  }
}
