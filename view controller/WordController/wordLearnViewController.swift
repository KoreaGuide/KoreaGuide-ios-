//
//  wordMainViewController.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/05.
//

import Foundation
import UIKit

class wordLearnViewController : UIViewController {
    var placeTitle: String = "";
    var kor: Bool = true;
    var totalWord: Int = 0
    var currentWord: Int = 0 // start from 1
    
    @IBOutlet weak var placeTitleLabel: UINavigationItem!
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var wordView: UIView!
    
    @IBAction func leftButton(_ sender: UIButton) {
        if(currentWord > 1){
            currentWord = currentWord - 1;
            wordView.setNeedsDisplay();
            NotificationCenter.default.post(name: .didChangeLanguage, object: self, userInfo: nil)
        }
        else{
            
        }
    }
    
    @IBAction func rightButton(_ sender: UIButton) {
        if(currentWord < totalWord){
            currentWord = currentWord + 1;
            wordView.setNeedsDisplay();
            NotificationCenter.default.post(name: .didChangeLanguage, object: self, userInfo: nil)
        }
        else{
            
        }
    }
    
    @IBAction func tapRecognized(_ sender: UITapGestureRecognizer) {
        kor = !(kor)
        NotificationCenter.default.post(name: .didChangeLanguage, object: self, userInfo: nil)
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pronunLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    
    @IBAction func playButton(_ sender: Any, forEvent event: UIEvent) {
    }
    
    @objc func onDidChangeLanguage(_ notification:Notification) {
        // reload content using selected language.
        nameLabel.text = "";
        pronunLabel.text = "";
        meaningLabel.text = "";
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidChangeLanguage(_:)), name: .didChangeLanguage, object: nil)
        
        wordView.layer.cornerRadius = 20;
        wordView.layer.masksToBounds = true;
        
        
        placeTitleLabel.title = "";
        wordCountLabel.text = "";
        progressView.progress = 0.5;
        //imageView
        
        if(kor){
            nameLabel.text = "";
            pronunLabel.text = "";
            meaningLabel.text = "";
        }
        else{
            nameLabel.text = "";
            pronunLabel.text = "";
            meaningLabel.text = "";
        }
        
        
    }
}

extension Notification.Name {
    static let didChangeLanguage = Notification.Name("didChangeLanguage")
}
