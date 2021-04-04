//
//  wordLearnBoxViewController.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/05.
//

import Foundation
import UIKit

class wordLearnBoxViewController : UIViewController {
    
    @IBOutlet weak var wordImageView: UIImageView!
    
    @IBOutlet weak var wordKorLabel: UILabel!
    
    @IBOutlet weak var wordPronunLabel: UILabel!
    
    @IBOutlet weak var wordMeaningLabel: UILabel!
    
    
    @IBAction func pronunPlayButton(_ sender: Any, forEvent event: UIEvent) {
        
        //play audio
    }
    
    @IBAction func tapRecognizer(_ sender: UITapGestureRecognizer) {
        //change kor - eng
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
