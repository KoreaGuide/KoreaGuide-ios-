//
//  TodayWordViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import Combine
import Foundation

class TodayWordViewModel: ObservableObject {
  @Published var word: TodayWord?
  @Published var word_id: Int = -1

  init() {
    // self.word_id = word_id

    WordApiCaller.homeRead { result in
      self.word_id = result?.data.word_id ?? 1
      
      WordApiCaller.oneWordRead(word_id: result?.data.word_id ?? 0) { result in
        let status = Int(result!.result_code)
        switch status {
        case 200:
          self.word = TodayWord(word: result!.data)
        default:
          print("----- one word read api error")
        }
      }
      
    }

 
  }

  func addWord() {
    WordApiCaller.myWordCreate(word_folder_id: 0, word_id: word_id) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        print("----- today word add api done")
      default:
        print("----- today word add api error")
      }
    }
  }
}