//
//  CardCell.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/27.
//

import Foundation
import IGListKit
import SDWebImage

final class CardCell: UICollectionViewCell {
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var title_kor: UILabel!
  @IBOutlet var title_eng: UILabel!
  override func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? CardViewModel else {
      return
    }
    layer.borderWidth = 2
    layer.borderColor = UIColor.white.cgColor
    title_kor.text = viewModel.title_kor
    title_eng.text = viewModel.title_eng
    let url = URL(string: viewModel.image)
    imageView.sd_setImage(with: url)
    print("3")
  }
  
}
