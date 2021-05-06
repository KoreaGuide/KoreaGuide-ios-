//
//  postingCell.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/04/05.
//

import Foundation
import IGListKit

final class PostingCell: UICollectionViewCell {
  @IBOutlet var title_kor: UILabel!
  @IBOutlet var title_eng: UILabel!
  @IBOutlet var overview: UITextView!
  @IBOutlet var seg: UISegmentedControl!
  var overview_kor: String?
  var overview_eng: String?
  override func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? PostingViewModel else { return }

    let str = viewModel.title
    let arr = str.components(separatedBy: "(")
    print("@@@@ \(str)")

    let strRange = arr[1].startIndex ..< arr[1].index(before: arr[1].endIndex)
    if arr[1].hasSuffix(")") {
      title_kor.text = String(arr[1][strRange])
      title_eng.text = arr[0]
    } else {
      title_kor.text = arr[1]
      title_eng.text = arr[0]
    }

    overview.text = viewModel.overview_Kor
    overview_eng = viewModel.overview_Eng
    overview_kor = viewModel.overview_Kor
    let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    seg.setTitleTextAttributes(titleTextAttributes, for: .normal)
    seg.setTitleTextAttributes(titleTextAttributes, for: .selected)
  }

  @IBAction func sgChangeLanguage(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      overview.text = overview_kor
    } else if sender.selectedSegmentIndex == 1 {
      overview.text = overview_eng
    }
  }
}
