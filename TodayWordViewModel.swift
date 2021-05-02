//
//  TodayWordViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import Foundation
import Combine

class TodayWordViewModel: ObservableObject {
  @Published var wordInfo: WordInfo
  var word_id: Int = 0
  
  init(wordInfo: WordInfo){ // api/home/  "word_id": 2,
    self.wordInfo = wordInfo
    
    WordApiCaller.homeRead() { result in
      self.word_id = result?.data.word_id ?? 0
      
    }
  }
}
