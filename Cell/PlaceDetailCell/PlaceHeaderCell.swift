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
  @IBOutlet var BookMarkButton: UIButton!
  var place_id : Int = 0
  var place_status : PlaceStatus?
  weak var delegate: HeaderCellDelegate?
  override func awakeFromNib() {
    super.awakeFromNib()
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
    place_id = viewModel.place_id
    place_status = viewModel.place_status
    if viewModel.place_status != .not {
      BookMarkButton.isSelected = true
    }
  }
  
  @objc func onClickBookMark() {
    delegate?.didTapBookMark(cell: self)
  }
  
  @objc func onClick() {
    delegate?.didTab(cell: self)
  }
  
  
}

protocol HeaderCellDelegate: class {
  func didTab(cell: PlaceHeaderCell)
  func didTapBookMark(cell: PlaceHeaderCell)
}
