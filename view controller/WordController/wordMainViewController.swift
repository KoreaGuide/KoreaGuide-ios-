//
//  wordMainViewController.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/05.
//

import Foundation
import UIKit

class wordMainViewController : UIViewController {
    @IBOutlet weak var placeTitleLabel: UINavigationItem!
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var wordView: UIView!
    
    func customEnableDragging(on view: UIView, dragInteractionDelegate: UIDragInteractionDelegate) {
        let dragInteraction = UIDragInteraction(delegate: dragInteractionDelegate)
        view.addInteraction(dragInteraction)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeTitleLabel.title = "";
        //wordView.layer.cornerRadius = 10;
        
        //customEnableDragging(wordView, )
    }
}
