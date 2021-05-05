//
//  WordLearnViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import Foundation

class WordLearnViewModel: ObservableObject {
  @Published var todayword: LearningWord
  
  init(wordInfo: LearningWord){
    self.todayword = wordInfo
  }
}
