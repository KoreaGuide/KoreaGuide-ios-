//
//  CardViewModel.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/27.
//

import Foundation
import IGListKit

final class CardViewModel: ListDiffable {
  let title_kor: String
  let title_eng: String
  let image : String
  init (title_kor: String, title_eng:String , image: String)
  {
    self.title_kor = title_kor
    self.title_eng = title_eng
    self.image = image
  }
}
extension CardViewModel {
  func diffIdentifier() -> NSObjectProtocol {
     return "Card" as NSObjectProtocol
  }
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? CardViewModel else {
      return false
    }
    return title_kor == object.title_kor
  }
}
