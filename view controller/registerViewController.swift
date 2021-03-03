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
    override func viewDidLoad() {
        super.viewDidLoad()
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
        registerButton.layer.cornerRadius = 20
        registerButton.backgroundColor = #colorLiteral(red: 0.2038938701, green: 0.2274695039, blue: 0.3450517654, alpha: 1)
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapLow(_ sender: Any) {
        lowButton.isSelected = true
        lowButton.backgroundColor = .blue
    }
    @IBAction func didTapMid(_ sender: Any) {
        midButton.isSelected = true
        midButton.backgroundColor = .blue
    }
    @IBAction func didTapHigh(_ sender: Any) {
        highButton.isSelected = true
        highButton.backgroundColor = .blue
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
