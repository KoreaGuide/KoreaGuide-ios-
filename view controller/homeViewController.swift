//
//  homeViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/03.
//

import Foundation
import UIKit

class homeViewController: UIViewController {
    @IBOutlet var menuButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func didTapButton(_ sender: Any) {
        ApiHelper.homeRead { status in
                switch status {
              
                case 409:
                    self.defaultAlert(title: "알람", message: "이미 가입되어 있는 이메일입니다.", callback: nil)

                case 201:
                    self.defaultAlert(title: "알람", message: "계정이 생성되었습니다.",callback: nil)
                default:
                    self.defaultAlert(title: "알람", message: "서버 장애가 발생하였습니다. ", callback: nil)
                }
        }
    }
    
    
}
