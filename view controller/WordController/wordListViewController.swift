//
//  wordListViewController.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/05.
//

import Foundation
import UIKit

class wordListViewController : UIViewController {
    //let wordStoryboard : UIStoryboard = UIStoryboard(name: "Word", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func learnButton(_ sender: Any) {
        let wordLearnViewController = self.storyboard?.instantiateViewController(identifier: "wordLearnView")
        self.show(wordLearnViewController!, sender: self)
        
    }
    
    @IBAction func testButton(_ sender: Any) {
        let testTypeChoiceViewController = self.storyboard?.instantiateViewController(identifier: "testListView")
        self.show(testTypeChoiceViewController!, sender: self)
    }

    

}



class wordCollectionViewCell : UICollectionViewCell {
    convenience override init(frame: CGRect) {
        self.init(frame: frame)
        var blurEffect: UIVisualEffect
        blurEffect = UIBlurEffect(style: .light)
        var visualEffectView: UIVisualEffectView
        visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.mask!.bounds
        self.addSubView(visualEffectView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mask!.frame = self.contentView.bounds
    }
}
