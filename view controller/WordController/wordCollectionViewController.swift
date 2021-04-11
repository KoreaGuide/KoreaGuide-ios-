//
//  wordCollectionViewController.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/10.
//

import UIKit

class wordCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var words = ["1", "2", "3"]
    var selectedIndexPath: IndexPath?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.backgroundColor = CGColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        self.selectedIndexPath = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.backgroundColor =  CGColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        self.selectedIndexPath = nil
    }
    
    @IBOutlet var wordCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wordCell", for: indexPath) as! wordCollectionViewCell
        if self.selectedIndexPath != nil && indexPath == self.selectedIndexPath {
            cell.layer.backgroundColor = CGColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        }
        else{
            cell.layer.backgroundColor = CGColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        }
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
