//
//  registerViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/02/18.
//

import UIKit

class registerViewController: UIViewController {
    
    @IBOutlet var emailTextField : UITextField!
    @IBOutlet var nicknameTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var passwordCheckTextField : UITextField!
    @IBOutlet var lowButton : UIButton!
    @IBOutlet var midButton : UIButton!
    @IBOutlet var highButton : UIButton!
    @IBOutlet var registerButton : UIButton!
    @IBOutlet var dismissButton : UIButton!
    @IBOutlet var emailCheckButton : UIButton!
    var didCheckEmail: Bool = false
    var buttons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [lowButton, midButton, highButton]
        buttons.forEach { $0.isSelected = false}
        lowButton.setTitle("LOW", for: .normal)
        midButton.setTitle("MID", for: .normal)
        highButton.setTitle("HIGH", for: .normal)
        emailTextField.layer.borderWidth = 2.0
        emailTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.layer.cornerRadius = 25
        emailTextField.clipsToBounds = true
        emailTextField.attributedPlaceholder = NSAttributedString(string: "  Enter email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.cornerRadius = 25
        passwordTextField.clipsToBounds = true
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "  Enter password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        nicknameTextField.layer.borderWidth = 2.0
        nicknameTextField.layer.borderColor = UIColor.white.cgColor
        nicknameTextField.layer.cornerRadius = 25
        nicknameTextField.clipsToBounds = true
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "  Enter nickname", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        passwordCheckTextField.layer.borderWidth = 2.0
        passwordCheckTextField.layer.borderColor = UIColor.white.cgColor
        passwordCheckTextField.layer.cornerRadius = 25
        passwordCheckTextField.clipsToBounds = true
        passwordCheckTextField.attributedPlaceholder = NSAttributedString(string: "  Enter password again", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        emailCheckButton.layer.borderWidth = 2.0
        emailCheckButton.layer.borderColor = UIColor.white.cgColor
        emailCheckButton.layer.cornerRadius = 15
        
        
        lowButton.layer.borderColor = UIColor.white.cgColor
        lowButton.layer.borderWidth = 2
        lowButton.layer.cornerRadius = 20
        
        midButton.layer.borderColor = UIColor.white.cgColor
        midButton.layer.borderWidth = 2
        midButton.layer.cornerRadius = 20
        
        highButton.layer.borderColor = UIColor.white.cgColor
        highButton.layer.borderWidth = 2
        highButton.layer.cornerRadius = 20
        
        registerButton.layer.borderColor = UIColor.white.cgColor
        registerButton.layer.borderWidth = 2
        registerButton.layer.cornerRadius = 15
        registerButton.backgroundColor = #colorLiteral(red: 0.2038938701, green: 0.2274695039, blue: 0.3450517654, alpha: 1)
        
        
        dismissButton.layer.borderColor = UIColor.white.cgColor
        dismissButton.layer.borderWidth = 2
        dismissButton.layer.cornerRadius = 15
        dismissButton.backgroundColor = #colorLiteral(red: 0.2038938701, green: 0.2274695039, blue: 0.3450517654, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    private var presentingController: UIViewController?
    override func viewWillAppear(_ animated: Bool) {
      presentingController = presentingViewController
      /*NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)*/
    }
    
    @IBAction func didTapLow(_ sender: Any) {
        buttons.forEach{$0.isSelected = false}
        lowButton.isSelected = true
        lowButton.backgroundColor = .blue
    }
    @IBAction func didTapMid(_ sender: Any) {
        buttons.forEach{$0.isSelected = false}
        midButton.isSelected = true
        midButton.backgroundColor = .blue
    }
    @IBAction func didTapHigh(_ sender: Any) {
        buttons.forEach{$0.isSelected = false}
        highButton.isSelected = true
        highButton.backgroundColor = .blue
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
            self.dismiss(animated: true, completion: {
                self.presentingController?.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    @IBAction func didTapDone(_ sender: Any) {
        var level : String?
        guard let email = emailTextField.text, !email.isEmpty else { unfinishedAlert(problem: "이메일(email)")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty, 8 ... 15 ~= password.count,
              !password.contains(email), !password.contains(" "), !password.contains("&"), !password.contains("|"), !password.contains("<"),
              !password.contains(">") else { unfinishedAlert(problem: "비밀번호(Password")
            return
        }
        
        guard let nickName = nicknameTextField.text, !nickName.isEmpty else { unfinishedAlert(problem: "닉네임(nickName)")
            return
        }
        
        guard didCheckEmail else {
            defaultAlert(title: "알람", message: "이메일 중복확인을 진행하지 않았습니다", callback: nil)
            return
        }
        for lev in buttons {
            if(lev.isSelected) {
                level = lev.title(for: .normal)
            }
        }
        
        guard !level!.isEmpty else {
            unfinishedAlert(problem: "레벨(level)")
            return
        }
        
        ApiHelper.register(email: email, password: password, nickName: nickName, level: level!) { status in
            switch status {
          
            case 409:
                self.defaultAlert(title: "알람", message: "이미 가입되어 있는 이메일입니다.", callback: nil)

            case 201:
                self.defaultAlert(title: "알람", message: "계정이 생성되었습니다.") { _ in
                  self.dismiss(animated: true, completion: {
                    self.presentingController?.dismiss(animated: true, completion: nil)
                })
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
