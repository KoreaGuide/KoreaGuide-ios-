//
//  wordListViewController.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/05.
//

import Foundation
import UIKit

class wordListViewController : UIViewController {
    let wordStoryboard : UIStoryboard = UIStoryboard(name: "Word", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func learnButton(_ sender: Any) {
        let wordLearnViewController = wordStoryboard.instantiateViewController(identifier: "wordLearnView")
        self.show(wordLearnViewController, sender: self)
        
    }
    
    @IBAction func testButton(_ sender: Any) {
        let testTypeChoiceViewController = wordStoryboard.instantiateViewController(identifier: "testListView")
        self.show(testTypeChoiceViewController, sender: self)
    }
}
