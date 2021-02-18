//
//  loginViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/02/15.
//

import UIKit
import Foundation
class loginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.layer.borderWidth = 2.0
        idTextField.layer.borderColor = UIColor.white.cgColor
        idTextField.layer.cornerRadius = 30
        idTextField.clipsToBounds = true
        idTextField.attributedPlaceholder = NSAttributedString(string: "  Enter ID", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.cornerRadius = 30
        passwordTextField.clipsToBounds = true
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "  Enter password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        // Do any additional setup after loading the view.
    }
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signButton: UIButton!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
