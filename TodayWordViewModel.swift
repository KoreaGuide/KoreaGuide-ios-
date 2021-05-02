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
  
  init(wordInfo: WordInfo){ // api/home/  "word_id": 2,
    self.wordInfo = wordInfo
  }
}
