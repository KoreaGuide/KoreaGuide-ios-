//
//  MapCell.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/04/05.
//

import Foundation
import IGListKit

final class MapCell: UICollectionViewCell {
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? MapViewModel else { return }
  }
}
