//
//  WordAddViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/26.
//

import Foundation
import Combine


class WordBoxViewModel: ObservableObject {

  @Published var currentCount: Int
  @Published var wordInfo: WordInfo
  //@Published var added: Bool = false
  //@Published var playing: Bool = false
  
  init(currentCount: Int, wordInfo: WordInfo) {
    self.currentCount = currentCount
    self.wordInfo = wordInfo
    
  
  }
}


class WordAddViewModel: ObservableObject {
  var place_id: Int = 0
  var user_id: Int = 0
  init(place_id : Int, user_id: Int){
    self.place_id = place_id
    self.user_id = user_id
    
    //place detail call -> place title
    
    WordApiCaller.placeRelatedWords(place_id: 0, page_num: 0) { status in
    
    
    }
    
  }
  
  func add(word_id: Int) -> Void {
    //api/myWord/{id} **여기서 id는 user의 id (Integer)
    //"word_folder_id": 2,
    //"word_id": 1
  }
  
  @Published var placeTitle: String = "place title place title"
  
  @Published var wordList: [WordInfo] =  [WordInfo(word_id: 1, word: "첫번째 단어", meaning: "first word"), WordInfo(word_id: 2, word: "두번째 단어", meaning: "second word"), WordInfo(word_id: 3, word: "세번째 단어", meaning: "third word")]
  

  
  @Published var added_word_id: Int = 0
  @Published var added_word_id_list: [Int] = []
  
 
  
  @Published var totalWordCount: Int = 3// 1~
  
  // 1~ -> index naming
  @Published var currentWordCount: Int = 0 {
    willSet{
      self.currentWordCountForShow = newValue + 1
    }
  }
  
  @Published var currentWordCountForShow: Int = 1 {
    willSet{
      self.progressValue = Float(newValue) / Float(self.totalWordCount)
    }
  }
  
  @Published var progressValue: Float =  0.0
  //@Published var progressValue: Float = 0
 
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

