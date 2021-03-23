//
//  CardViewCell.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/22.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    @IBOutlet var place_image: UIImageView!
    @IBOutlet var place_title_kor: UILabel!
    @IBOutlet var place_title_eng: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
