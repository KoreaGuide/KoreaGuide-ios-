//
//  TodayWordViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import Foundation
import Combine

class TodayWordViewModel: ObservableObject {
  //@Published var word: TodayWord
  var word_id: Int = 0
  
  init(word_id: Int){
    self.word_id = word_id
  }
  init(){
    WordApiCaller.homeRead() { result in
      self.word_id = result?.data.word_id ?? 0
    }
  }
  
  
}
