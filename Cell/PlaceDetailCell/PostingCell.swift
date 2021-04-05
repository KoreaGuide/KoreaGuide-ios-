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
  @IBOutlet var seg : UISegmentedControl!
  var overview_kor : String?
  var overview_eng : String?
  override func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? PostingViewModel else { return }
    title_kor.text = viewModel.title
    title_eng.text = viewModel.title
    overview.text = viewModel.overview_Kor
    overview_eng = viewModel.overview_Eng
    overview_kor = viewModel.overview_Kor
  }
  
  @IBAction func sgChangeLanguage(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      self.overview.text = overview_kor
    } else if sender.selectedSegmentIndex == 1 {
      self.overview.text = overview_eng
    }
  }
}
