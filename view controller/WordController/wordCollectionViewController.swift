//
//  wordCollectionViewController.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/10.
//

import UIKit

final class wordCollectionViewController: UICollectionViewController {
    private let reuseIdentifier = "wordCell"
    //private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    //private let itemsPerRow: CGFloat = 3
    
    @IBOutlet var wordCollectionView: UICollectionView!
    
    
    var wordlist = [""]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordlist.count
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wordCell", for: indexPath) as! wordCollectionViewCell
        
        cell.backgroundColor = .lightGray
        
        return cell
    }
}

class wordCollectionViewCell : UICollectionViewCell{
    
    @IBOutlet weak var wordCellLabel: UILabel!
    
}
/*
extension wordCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return wordlist.count
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordlist.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
}
*/


extension wordCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 1
        
        let size = CGSize(width: width, height: width)
        return size
    }
}
