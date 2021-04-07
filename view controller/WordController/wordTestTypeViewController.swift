//
//  wordTestTypeViewController.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/05.
//

import Foundation
import UIKit



class wordTestTypeViewController : UIViewController {
    @IBOutlet weak var testTypeTitleLabel: UINavigationItem!
    
    @IBOutlet weak var vocabInfoView: UIView!
    
    @IBOutlet weak var type1View: UIView!
    @IBOutlet weak var type2View: UIView!
    @IBOutlet weak var type3View: UIView!
    @IBOutlet weak var type4View: UIView!
    
    let gesture = UITapGestureRecognizer(target: UIView(), action: Selector(("selected")))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vocabInfoView.layer.cornerRadius = 10;
        
        type1View.layer.cornerRadius = 10;
        type2View.layer.cornerRadius = 10;
        type3View.layer.cornerRadius = 10;
        type4View.layer.cornerRadius = 10;
       
        type1View.addGestureRecognizer(gesture)
        
        
    }
    
    func selected(_ sender: UITapGestureRecognizer){
        
    }
    
    
}
