//
//  wordCollectionViewController.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/10.
//

import UIKit

final class wordCollectionViewController: UICollectionViewController {
    private let reuseIdentifier = "wordCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 3
    
}



extension wordCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return wordlist.count
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordlist[section].results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
}



extension wordCollectionViewController: UICollectionViewFlowLayout {
    func collectionView()
}
