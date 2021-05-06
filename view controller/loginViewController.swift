//
//  loginViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/02/15.
//

import Foundation
import UIKit

class loginViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    idTextField.layer.borderWidth = 2.0
    idTextField.layer.borderColor = UIColor.white.cgColor
    idTextField.layer.cornerRadius = 27
    idTextField.clipsToBounds = true
    idTextField.attributedPlaceholder = NSAttributedString(string: "Enter ID", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    idTextField.backgroundColor = .clear
    idTextField.addLeftPadding()
    passwordTextField.layer.borderWidth = 2.0
    passwordTextField.layer.borderColor = UIColor.white.cgColor
    passwordTextField.layer.cornerRadius = 27
    passwordTextField.clipsToBounds = true
    passwordTextField.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    passwordTextField.backgroundColor = .clear
    passwordTextField.addLeftPadding()
    // Do any additional setup after loading the view.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name:
      UIResponder.keyboardWillChangeFrameNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  @objc func keyboardWillHide() {
    view.frame.origin.y = 0
  }

  @objc func keyboardWillChange(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      if idTextField.isFirstResponder {
        view.frame.origin.y = -keyboardSize.height
      }
      if passwordTextField.isFirstResponder {
        view.frame.origin.y = -keyboardSize.height
      }
    }
  }

  @IBAction func didTapLoginButton(_ sender: Any) {
    guard let loginEmail = idTextField.text else {
      defaultAlert(title: "경고", message: "이메일값이 비어있습니다", callback: nil)
      return
    }
    guard let password = passwordTextField.text else {
      defaultAlert(title: "경고", message: "비밀번호값이 비어있습니다", callback: nil)
      return
    }
    // let encodedPassword = PasswordEncoder().encode(password: password)!
    ApiHelper.login(email: loginEmail, password: password) { status in
      print(status ?? -1)
      switch status {
      case 500:
        self.defaultAlert(title: "경고", message: "아이디가 없습니다.", callback: nil)
      case 409:
        self.defaultAlert(title: "경고", message: "비밀번호가 틀렸습니다.", callback: nil)
      case 200:
        // 성공
        // 라벨 비워주기 (로그아웃 후 이 뷰로 돌아오므로)
        self.idTextField.text = ""
        self.passwordTextField.text = ""
        self.performSegue(withIdentifier: "home", sender: self)
      case 204 :
        self.idTextField.text = ""
        self.passwordTextField.text = ""
        self.performSegue(withIdentifier: "home", sender: self)
      case 3:
        self.defaultAlert(title: "경고", message: "이메일 인증 전입니다.", callback: nil)
      default:
        print("알 수 없는 에러 발생")
        return
      }
    }
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
