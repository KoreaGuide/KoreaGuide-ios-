//
//  File.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/04/05.
//

import Foundation
import UIKit

final class PlaceHeaderCell: UICollectionViewCell {
  @IBOutlet var title: UILabel!
  @IBOutlet var leftButton: UIButton!
  @IBOutlet var placeAddButton: UIButton!
  @IBOutlet var placeStatusButton: UIButton!
  
  override class func awakeFromNib() {
    super.awakeFromNib()
  }
}
