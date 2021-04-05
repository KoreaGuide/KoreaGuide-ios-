//
//  CardViewCell.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/22.
//

import IGListKit
import UIKit
class CardViewCell: UICollectionViewCell, ListBindable {
  func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? home_data else { fatalError() }
    let url = URL(fileURLWithPath: viewModel.first_image)

    DispatchQueue.global().async {
      let image = try? Data(contentsOf: url)
      DispatchQueue.main.async {
        self.place_image?.image = UIImage(data: image!)
      }
    }
    place_title_kor?.text = viewModel.title
    place_title_eng?.text = viewModel.title
  }

  @IBOutlet var place_image: UIImageView!
  @IBOutlet var place_title_kor: UILabel!
  @IBOutlet var place_title_eng: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
}
