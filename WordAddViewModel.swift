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
  @Published var added: Bool = false
  @Published var playing: Bool = false

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

  @Published var added_word_id_list: [Int] = []
  @Published var removed_word_id_list: [Int] = []
  
  @Published var totalWordCount: Int = 1
  // 1~ -> index naming
  @Published var currentWordCount: Int = 0 {
    willSet {
      currentWordCountForShow = newValue + 1
    }
  }

  @Published var currentWordCountForShow: Int = 1 {
    willSet {
      progressValue = Float(newValue) / Float(totalWordCount)
    }
  }

  @Published var progressValue: Float = 0.1

  @Published var finish: Bool = false

  init(place_id: Int) {
    self.place_id = place_id
  }
  
  func getter() {
    // place detail call -> place title
    WordApiCaller.placeDetailAllRead(place_id: self.place_id) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        self.place_title = result?.data.title ?? ""
      default:
        print("----- place detail all read api error")
      }
    }

    // place id -> related word list
    WordApiCaller.placeRelatedWords(place_id: self.place_id) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        self.word_list = result?.data.word_list as! [AddingWord]
      default:
        print("----- place related words api error")
      }
    }
    totalWordCount = word_list.count
    
    self.$finish
      .receive(on: RunLoop.main)
      //.filter($0)
      .sink{_ in
        
      }
      .store(in: &cancellable)
  }

  func add(word_id: Int) {
    // api/myWord/{id} **여기서 id는 user의 id (Integer)
    // "word_folder_id": 2,
    // "word_id": 1
  }

  func remove() {}

  private var cancellable: Set<AnyCancellable> = []

  
}
