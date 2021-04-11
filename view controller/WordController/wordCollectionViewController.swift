//
//  wordCollectionViewController.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/10.
//

import UIKit

class wordCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var words = ["1", "2", "3"]
    
    @IBOutlet var wordCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wordCell", for: indexPath) as! wordCollectionViewCell
        
        cell.backgroundColor = .lightGray
        cell.wordCellLabel.text = words[indexPath.row]
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wordCollectionView.delegate = self
        self.wordCollectionView.dataSource = self
    }
}

extension wordCollectionViewController: UICollectionViewDelegateFlowLayout {
    //위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    //옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 1
        let size = CGSize(width: width, height: width)
        return size
    }
}

class wordCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var wordCellLabel: UILabel!
}
