//
//  AlertExtensions.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/13.
//

import Foundation
import UIKit

extension UIViewController {
    func defaultAlert(title: String, message: String, callback: ((UIAlertAction) -> Void)?) {
        var alert: UIAlertController
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "확인", style: .destructive, handler: callback)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func defaultAlertWithCancle(title: String, message: String, callback: ((UIAlertAction) -> Void)?) {
        var alert: UIAlertController
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let defaultAction = UIAlertAction(title: "확인", style: .destructive, handler: callback)
        alert.addAction(cancleAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
