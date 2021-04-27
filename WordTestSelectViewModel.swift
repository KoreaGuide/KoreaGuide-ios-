//
//  WordTestSelectViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/28.
//

import Foundation
import Combine


class WordTestSelectViewModel: ObservableObject {
  @Published var wordlist: [WordInfo]
  
  
  init(wordlist: [WordInfo]){
    self.wordlist = wordlist
  }
}
