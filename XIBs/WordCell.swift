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
  
  @IBOutlet var today: UILabel!
  @IBOutlet var button: UIButton!
  var word_audio : String = ""
  weak var delegate: WordCellDelegate? = nil
  override func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? WordViewModel else { return }
    word.text = viewModel.word
    let url = URL(string: viewModel.word_image)
    word_image.sd_setImage(with: url)
    self.word_audio = viewModel.word_audio
    self.layer.borderWidth=2
    self.layer.borderColor = UIColor.white.cgColor
    self.layer.cornerRadius = 30
    
    today.text = "Word of today"
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    button.addTarget(self, action: #selector(WordCell.onClick), for: .touchUpInside)
  }
  @objc func onClick() {
    delegate?.didTap(cell: self)
  }
}

protocol WordCellDelegate: class {
  func didTap(cell: WordCell)
}
