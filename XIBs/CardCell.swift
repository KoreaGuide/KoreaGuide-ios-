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
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet var title_kor: UILabel!
  @IBOutlet var title_eng: UILabel!
  
  override func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? CardViewModel else {
      return
    }
    title_kor.text = viewModel.title_kor
    title_eng.text = viewModel.title_eng
    let url = URL(fileURLWithPath: viewModel.image)
    imageView.sd_setImage(with: url)
  }
}
