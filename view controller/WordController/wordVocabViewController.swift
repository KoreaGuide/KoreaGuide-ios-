//
//  wordVocabViewController.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/05.
//

import Foundation
import UIKit

class wordVocabViewController : UIViewController {
    
    let wordStoryboard : UIStoryboard = UIStoryboard(name: "Word", bundle: nil)
    
    
    @IBOutlet weak var vocabTopLabel: UILabel!
    @IBOutlet weak var totalWordLabel: UILabel!
    
  
    @IBAction func addedWordButton(_ sender: Any) {
        let wordListViewController = wordStoryboard.instantiateViewController(identifier: "wordListView")
        self.show(wordListViewController, sender: self)
    }
    @IBAction func learningWordButton(_ sender: Any) {
        let wordListViewController = wordStoryboard.instantiateViewController(identifier: "wordListView")
        self.show(wordListViewController, sender: self)
    }
    @IBAction func completeWordButton(_ sender: Any) {
        let wordListViewController = wordStoryboard.instantiateViewController(identifier: "wordListView")
        self.show(wordListViewController, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //when any word count changes
        totalWordLabel.text = "";
        
       
       
        
        
    }
}


