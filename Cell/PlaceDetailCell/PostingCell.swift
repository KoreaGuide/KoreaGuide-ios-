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
    overview.isEditable = false
    overview.text = viewModel.overview_Eng
    overview_eng = viewModel.overview_Eng
    overview_kor = viewModel.overview_Kor
    let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    seg.setTitleTextAttributes(titleTextAttributes, for: .normal)
    seg.setTitleTextAttributes(titleTextAttributes, for: .selected)
  }

  @IBAction func sgChangeLanguage(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      overview.text = overview_eng
    } else if sender.selectedSegmentIndex == 1 {
      let parseKor = overview_kor!.components(separatedBy: ".")
      let parseEng = overview_eng!.components(separatedBy: ".")
      let text = NSMutableAttributedString()
      for i in 0 ..< parseKor.count {
        if parseKor[i].hasPrefix(" ") {
          let attributeKor = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Bangla MN", size: 18), NSAttributedString.Key.backgroundColor: UIColor.init(hex: "F7CE46FF")]
          let attributeEng = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Arial", size: 14)]
          let attKor = NSAttributedString(string: String(parseKor[i].dropFirst() + ".\n"), attributes: attributeKor as [NSAttributedString.Key : Any])
          text.append(attKor)
          let attEng = NSAttributedString(string: String(parseEng[i].dropFirst() + ".\n\n"), attributes: attributeEng as [NSAttributedString.Key : Any])
          text.append(attEng)
        } else {
          let attributeKor = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Bangla MN", size: 18)]
          let attributeEng = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Arial", size: 15)]
          let attKor = NSAttributedString(string: String(parseKor[i] + ".\n"), attributes: attributeKor as [NSAttributedString.Key : Any])
          text.append(attKor)
          let attEng = NSAttributedString(string: String(parseEng[i] + ".\n\n"), attributes: attributeEng as [NSAttributedString.Key : Any])
          text.append(attEng)
        }
      }
      overview.attributedText = text

    } else if sender.selectedSegmentIndex == 2 {
      overview.text = overview_kor
    }
  }
}
