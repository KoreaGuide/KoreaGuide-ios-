//
//  WordViewModel.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/27.
//

import Foundation
import IGListKit
final class WordViewModel : ListDiffable{
  let word_id: Int
  let word: String
  let word_image: String
  let word_audio: String
  init (word_id: Int, word: String, word_image: String, word_audio:String)
  {
    self.word_id = word_id
    self.word = word
    self.word_image = word_image
    self.word_audio = word_audio
  }
  init (key: home_keys)
  {
    self.word_id = key.word_id
    self.word = key.word
    self.word_image = key.word_image
    self.word_audio = key.word_audio
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
