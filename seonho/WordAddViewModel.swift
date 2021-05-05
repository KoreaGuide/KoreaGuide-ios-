//
//  WordAddViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/26.
//

import Combine
import Foundation
import SwiftUI

class WordBoxViewModel: ObservableObject {
  @Published var currentCount: Int
  @Published var word: AddingWord

  // @Published var playing: Bool = false

  init(currentCount: Int, word: AddingWord) {
    self.currentCount = currentCount
    self.word = word
  }
}

class WordAddViewModel: ObservableObject {
  var place_id: Int = 0
  var place_title: String = ""
  var user_id: Int = UserDefaults.id!

  var word_list: [AddingWord] = []

  @Published var addButton: Bool = false

  var result: [(Int, Int, Bool)] = [] // 순서, word id, add or not
  
  @Published var added_word_id_list: [Int] = []
  @Published var removed_word_id_list: [Int] = []

  @Published var totalWordCount: Int = 1
  // 1~ -> index naming
  @Published var currentWordCount: Int = 0 {
    willSet {
      progressValue = Float(newValue) / Float(totalWordCount)
    }
  }
  @Published var progressValue: Float = 0.0

  @Published var finish: Bool = false
  private var cancellable: Set<AnyCancellable> = []

  init(place_id: Int) {
    self.place_id = place_id
  }

  func setting() {
    // place detail call -> place title
    WordApiCaller.placeDetailAllRead(place_id: place_id) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        self.place_title = result?.data.title ?? ""
      default:
        print("----- place detail all read api error")
      }
    }

    // place id -> related word list
    WordApiCaller.placeRelatedWords(place_id: place_id) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        self.word_list = result?.data.word_list as! [AddingWord]
      default:
        print("----- place related words api error")
      }
    }
    totalWordCount = word_list.count

    $finish
      .receive(on: RunLoop.main)
      // .filter($0)
      .sink { _ in
      }
      .store(in: &cancellable)
  }

  func add(word_id: Int) {
    WordApiCaller.myWordCreate(word_folder_id: 0, word_id: word_id) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        print("----- today word add api done")
      default:
        print("----- today word add api error")
      }
    }

    func remove(word_id: Int) {
      WordApiCaller.myWordDelete(word_folder_id: 0, word_id: word_id) {
        result in
        let status = Int(result?.result_code ?? 500)
        switch status {
        case 200:
          print("----- my word delete api done")
        default:
          print("----- my word delete api error")
        }
      }

      WordApiCaller.myWordDelete(word_folder_id: 1, word_id: word_id) {
        result in
        let status = Int(result?.result_code ?? 500)
        switch status {
        case 200:
          print("----- my word delete api done")
        default:
          print("----- my word delete api error")
        }
      }

      WordApiCaller.myWordDelete(word_folder_id: 2, word_id: word_id) {
        result in
        let status = Int(result?.result_code ?? 500)
        switch status {
        case 200:
          print("----- my word delete api done")
        default:
          print("----- my word delete api error")
        }
      }
    }
  }
}
