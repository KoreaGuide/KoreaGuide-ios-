//
//  WordAddViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/26.
//

import Combine
import Foundation

class WordBoxViewModel: ObservableObject {
  @Published var currentCount: Int
  @Published var wordInfo: WordInfo?
  // @Published var added: Bool = false
  // @Published var playing: Bool = false

  init(currentCount: Int, wordInfo: WordInfo) {
    self.currentCount = currentCount
    self.wordInfo = wordInfo
  }

  init(currentCount: Int, word: Word) {
    self.currentCount = currentCount
    self.wordInfo?.word = wordInfo.word
    self.wordInfo?.word_id = wordInfo.word_id
  }
}

class WordAddViewModel: ObservableObject {
  @Published var place_id: Int
  @Published var user_id: Int?

  @Published var place_title: String?
  @Published var added_word_id_list: [Int] = []

  @Published var totalWordCount: Int = 3 // 1~

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

  @Published var progressValue: Float = 0.0

  var response: placeRelatedWordModel?

  init(place_id: Int) {
    // place detail call -> get place title
    self.place_id = place_id
    WordApiCaller.placeDetailAllRead(place_id: 0) { result in
      if Int(result!.result_code) == 200 {
        self.place_title = result?.data.title
        self.user_id = result?.data.user_id
      }
    }

    // place related words call
    WordApiCaller.placeRelatedWords(place_id: 0) { result in
      if Int(result!.result_code) == 200 {
        self.response = result
        // let data = self.response!.data
      }
    }
  }

  func add(word_id: Int) {
    // api/myWord/{id} **여기서 id는 user의 id (Integer)
    added_word_id_list.append(word_id)
    // "word_folder_id": 2,
    // "word_id": 1
  }

  func remove(word_id: Int) {
    added_word_id_list = added_word_id_list.filter { $0 != word_id }
  }

  /*
   private var cancellable: Set<AnyCancellable> = []

     // 카드가 골라졌는지 확인하기
     private var didSelectWordPublisher: AnyPublisher<Bool, Never> {
       $selectedWord
         .map { $0 != nil }
         .eraseToAnyPublisher()
     }

     init() {
       didSelectWordPublisher
         .receive(on: RunLoop.main)
         .assign(to: \.didSelectWord, on: self)
         .store(in: &cancellable)

       $selectedWord
         .map {
           if $0 != nil { return $0!.word_id } else { return 0 }
         }
         .receive(on: RunLoop.main)
         .assign(to: \.word_id, on: self)
         .store(in: &cancellable)
     }*/
}
