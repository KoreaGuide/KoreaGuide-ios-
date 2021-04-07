//
//  wordVocabViewController.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/05.
//

import Foundation
import UIKit

class wordVocabViewController : UIViewController {
    
    @IBOutlet weak var vocabTopLabel: UILabel!
    @IBOutlet weak var totalWordLabel: UILabel!
    
    @IBOutlet weak var addedFolder: UIView!
    @IBOutlet weak var learningFolder: UIView!
    @IBOutlet weak var completeFolder: UIView!
    
    @IBOutlet weak var addedWordLabel: UILabel!
    @IBOutlet weak var learningWordLabel: UILabel!
    @IBOutlet weak var completeWordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addedFolder.layer.cornerRadius = 10;
        learningFolder.layer.cornerRadius = 10;
        completeFolder.layer.cornerRadius = 10;
        
        addedFolder.alpha = 0.8;
        learningFolder.alpha = 0.8;
        completeFolder.alpha = 0.8;
        
        
    }
}


