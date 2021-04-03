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
  var place_id: Int!
  override func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? CardViewModel else {
      return
    }
    layer.borderWidth = 2
    layer.borderColor = UIColor.white.cgColor
    let str = viewModel.title_kor
    let arr = str.components(separatedBy: "(")
    let strRange = arr[1].startIndex ..< arr[1].index(before: arr[1].endIndex)
    print(arr[1][strRange])
    if arr[1].hasSuffix(")") {
      title_kor.text = String(arr[1][strRange])
      title_eng.text = arr[0]
    } else {
      title_kor.text = arr[1]
      title_eng.text = arr[0]
    }
    let url = URL(string: viewModel.image)
    place_id = viewModel.place_id
    imageView.sd_setImage(with: url)
    print("3")
  }
}
