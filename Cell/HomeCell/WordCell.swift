//
//  WordCell.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/27.
//

import Foundation
import IGListKit
final class WordCell: UICollectionViewCell {
  @IBOutlet var word: UILabel!
  @IBOutlet var word_image: UIImageView!

  @IBOutlet var today: UILabel!
  @IBOutlet var button: UIButton!
  var word_audio: String = ""
  var word_id: String = ""
  weak var delegate: WordCellDelegate?
  override func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? WordViewModel else { return }
    word.text = "Do you Know\nwhat "+viewModel.word+" is called\nin Korean?"
    word.numberOfLines = 3
    let url = URL(string: viewModel.word_image)
    word_image.sd_setImage(with: url)
    word_audio = viewModel.word_audio
    layer.cornerRadius = 30
    word_image.alpha = 0.6
    today.text = "Word of today"
    word_id = String(viewModel.word_id)
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
