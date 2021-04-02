//
//  ViewModel.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/27.
//

import Foundation
import IGListKit

final class Home: ListDiffable {
  //section controller에서 demux 해주는용
  func diffIdentifier() -> NSObjectProtocol {
    return "Home" as NSObjectProtocol
  }
  //cell 업데이트용
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    return true
  }

  let cards: [CardViewModel]
  let word: WordViewModel
  init(cards: [CardViewModel], word: WordViewModel) {
    self.cards = cards
    self.word = word
  }
}

final class CardViewModel: ListDiffable {
  let title_kor: String
  let title_eng: String
  let image: String
  let place_id : Int
  init(title_kor: String, title_eng: String, image: String, place_id: Int) {
    self.title_kor = title_kor
    self.title_eng = title_eng
    self.image = image
    self.place_id = place_id
  }

  init(card: HomeCard) {
    title_kor = card.title
    title_eng = card.title
    image = card.first_image
    place_id = card.id
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

final class WordViewModel: ListDiffable {
  let word_id: Int
  let word: String
  let word_image: String
  let word_audio: String
  init(word_id: Int, word: String, word_image: String, word_audio: String) {
    self.word_id = word_id
    self.word = word
    self.word_image = word_image
    self.word_audio = word_audio
  }

  init(key: home_keys) {
    word_id = key.word_id
    word = key.word
    word_image = key.word_image
    word_audio = key.word_audio
  }
}

extension WordViewModel {
  func diffIdentifier() -> NSObjectProtocol {
    return "Word" as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? WordViewModel else {
      return false
    }
    return word_id == object.word_id
  }
}
