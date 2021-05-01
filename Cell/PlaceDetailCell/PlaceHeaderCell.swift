//
//  File.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/04/05.
//

import Foundation
import IGListKit
import UIKit

final class PlaceHeaderCell: UICollectionViewCell {
  @IBOutlet var title: UILabel!
  @IBOutlet var leftButton: UIButton!
  @IBOutlet var placeAddButton: UIButton!
  @IBOutlet var placeStatusButton: UIButton!
  weak var delegate: HeaderCellDelegate?
  override func awakeFromNib() {
    super.awakeFromNib()

    leftButton.addTarget(self, action: #selector(PlaceHeaderCell.onClick), for: .touchUpInside)
  }

  override func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? PlaceDetailHeaderViewModel else { return }

    title.sizeToFit()
    leftButton.sizeToFit()
    let str = viewModel.place_title
    let arr = str.components(separatedBy: "(")
    let strRange = arr[1].startIndex ..< arr[1].index(before: arr[1].endIndex)
    if arr[1].hasSuffix(")") {
      title.text = String(arr[1][strRange])
    } else {
      title.text = arr[1]
    }
  }


  @objc func onClick() {
    delegate?.didTab(cell: self)
  }
}

protocol HeaderCellDelegate: class {
  func didTab(cell: PlaceHeaderCell)
}
