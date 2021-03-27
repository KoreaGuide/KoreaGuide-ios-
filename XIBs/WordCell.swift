//
//  WordCell.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/27.
//

import Foundation
import IGListKit
final class WordCell : UICollectionViewCell{
  @IBOutlet var word : UILabel!
  @IBOutlet weak var word_image: UIImageView!
  override func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? WordViewModel else { return }
    word.text = viewModel.word
    let url = URL(fileURLWithPath: viewModel.word_image)
    word_image.sd_setImage(with: url)
  }
  
  
}
