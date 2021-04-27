//
//  TodayWordViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import Foundation
import Combine

class TodayWordViewModel: ObservableObject {
  @Published var todayword: WordInfo
  
  init(wordInfo: WordInfo){
    self.todayword = wordInfo
  }
}
