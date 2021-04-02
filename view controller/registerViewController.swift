//
//  registerViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/02/18.
//

import UIKit

class registerViewController: UIViewController {
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var nicknameTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var passwordCheckTextField: UITextField!

  @IBOutlet var registerButton: UIButton!
  @IBOutlet var dismissButton: UIButton!
  var didCheckEmail: Bool = false
  var buttons: [UIButton]!

  override func viewDidLoad() {
    super.viewDidLoad()
    emailTextField.layer.borderWidth = 1.5
    emailTextField.layer.borderColor = UIColor.white.cgColor
    emailTextField.layer.cornerRadius = 25
    emailTextField.clipsToBounds = true
    emailTextField.attributedPlaceholder = NSAttributedString(string: "  Enter email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    passwordTextField.layer.borderWidth = 1.5
    passwordTextField.layer.borderColor = UIColor.white.cgColor
    passwordTextField.layer.cornerRadius = 25
    passwordTextField.clipsToBounds = true
    passwordTextField.attributedPlaceholder = NSAttributedString(string: "  Enter password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    nicknameTextField.layer.borderWidth = 1.5
    nicknameTextField.layer.borderColor = UIColor.white.cgColor
    nicknameTextField.layer.cornerRadius = 25
    nicknameTextField.clipsToBounds = true
    nicknameTextField.attributedPlaceholder = NSAttributedString(string: "  Enter nickname", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    passwordCheckTextField.layer.borderWidth = 1.5
    passwordCheckTextField.layer.borderColor = UIColor.white.cgColor
    passwordCheckTextField.layer.cornerRadius = 25
    passwordCheckTextField.clipsToBounds = true
    passwordCheckTextField.attributedPlaceholder = NSAttributedString(string: "  Enter password again", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

    registerButton.layer.borderColor = #colorLiteral(red: 0.3097642064, green: 0.345123291, blue: 0.4862119555, alpha: 1)
    registerButton.layer.borderWidth = 2
    registerButton.layer.cornerRadius = 27
    registerButton.backgroundColor = #colorLiteral(red: 0.06272603571, green: 0.09413032979, blue: 0.2195757329, alpha: 1)

    dismissButton.layer.borderColor = #colorLiteral(red: 0.3097642064, green: 0.345123291, blue: 0.4862119555, alpha: 1)
    dismissButton.layer.borderWidth = 2
    dismissButton.layer.cornerRadius = 22
    dismissButton.backgroundColor = #colorLiteral(red: 0.06272603571, green: 0.09413032979, blue: 0.2195757329, alpha: 1)
    // Do any additional setup after loading the view.
  }

  private var presentingController: UIViewController?
  override func viewWillAppear(_ animated: Bool) {
    presentingController = presentingViewController
    /* NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
     NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil) */
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }

  @IBAction func didTapEmailCheck(_ sender: Any) {
    guard let email = emailTextField.text, !email.isEmpty else { unfinishedAlert(problem: "이메일(email)")
      return
    }
    ApiHelper.emailCheck(email: email) { status in
      if status == 409 {
        self.defaultAlert(title: "알람", message: "이미 존재하는 아이디입니다.", callback: nil)
      } else if status == 200 {
        self.didCheckEmail = true
        self.defaultAlert(title: "알람", message: "사용할 수 있는 아이디입니다", callback: nil)
      }
    }
  }

  @IBAction func didTapDismiss(_ sender: Any) {
    print("취소 버튼 클릭됨")
    showAlert { _ in
      self.dismiss(animated: true, completion: nil)
    }
  }

  @IBAction func didTapDone(_ sender: Any) {
    guard let email = emailTextField.text, !email.isEmpty else { unfinishedAlert(problem: "이메일(email)")
      return
    }
    guard let password = passwordTextField.text, !password.isEmpty, 8 ... 15 ~= password.count,
          !password.contains(email), !password.contains(" "), !password.contains("&"), !password.contains("|"), !password.contains("<"),
          !password.contains(">")
    else { unfinishedAlert(problem: "비밀번호(Password")
      return
    }

    guard let nickName = nicknameTextField.text, !nickName.isEmpty else { unfinishedAlert(problem: "닉네임(nickName)")
      return
    }
    
    guard didCheckEmail else {
      defaultAlert(title: "알람", message: "이메일 중복확인을 진행하지 않았습니다", callback: nil)
      return
    }

    ApiHelper.register(email: email, password: password, nickName: nickName) { status in
      switch status {
      case 409:
        self.defaultAlert(title: "알람", message: "이미 가입되어 있는 이메일입니다.", callback: nil)

      case 201:
        self.defaultAlert(title: "알람", message: "계정이 생성되었습니다.") { _ in
          self.dismiss(animated: true, completion:nil)
        }
      default:
        self.defaultAlert(title: "알람", message: "서버 장애가 발생하였습니다. ", callback: nil)
      }
    }
  }

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Get the new view controller using segue.destination.
       // Pass the selected object to the new view controller.
   }
   */
  func showAlert(callback: ((UIAlertAction) -> Void)?) {
    var alert: UIAlertController
    alert = UIAlertController(title: "회원가입 취소", message: "작성하던 내용은 저장되지 않습니다. 취소하시겠어요?", preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "확인", style: .destructive, handler: callback)
    let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
    alert.addAction(defaultAction)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }

  func unfinishedAlert(problem: String) {
    var alert: UIAlertController
    alert = UIAlertController(title: "내부 오류 발생", message: "\(problem) 값이 비어있거나 형식에 맞지 않습니다.", preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "확인", style: .destructive, handler: nil)
    alert.addAction(defaultAction)
    present(alert, animated: true, completion: nil)
  }
  /*@objc func keyboardWillShow(sender: NSNotification) {
     let info = sender.userInfo!
     let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height

     bottomConstraint.constant = keyboardSize - bottomLayoutGuide.length

     let duration: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue

     UIView.animate(withDuration: duration) { self.view.layoutIfNeeded() }
   }

   @objc func keyboardWillHide(sender: NSNotification) {
     let info = sender.userInfo!

     let duration: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
     bottomConstraint.constant = 0

     UIView.animate(withDuration: duration) { self.view.layoutIfNeeded() }
   }*/
}
