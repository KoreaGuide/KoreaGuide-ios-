//
//  ViewModel.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/27.
//

import Foundation
import IGListKit

final class Home: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return "Home" as NSObjectProtocol
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    return true
  }
  let cards: [CardViewModel]
  let word: WordViewModel
  init (cards: [CardViewModel],word:WordViewModel)
  {
    self.cards = cards
    self.word = word
  }
}
