//
//  File.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/04/05.
//

import Foundation
import IGListKit
import SDWebImage

final class ImageCell: UICollectionViewCell {
  @IBOutlet var firstImage: UIImageView!
  @IBOutlet var leftButton: UIButton!
  
  @IBOutlet var rightButton: UIButton!
  var firstImage1 : String?
  var firstImage2 : String?
  weak var delegate: ImageCellDelegate?
  override func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? ImageViewModel else { return }
    firstImage1 = viewModel.first_image
    firstImage2 = viewModel.first_image2
    let url = URL(string: viewModel.first_image)
    firstImage.sd_setImage(with: url)
    
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  @objc func didTapLeftButton() {
    delegate?.didTapLeftButton(cell: self)
  }
  
  @objc func didTapRightButton() {
    delegate?.didTapRightButton(cell: self)
  }
}

protocol ImageCellDelegate: class {
  func didTapLeftButton(cell: ImageCell)
  func didTapRightButton(cell: ImageCell)
}
