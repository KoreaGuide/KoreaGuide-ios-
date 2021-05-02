//
//  WordMainViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/28.
//

import Combine
import Foundation

class WordMainViewModel: ObservableObject {
  @Published var wordlist: [WordInfo]

  init(wordlist: [WordInfo]) {
    self.wordlist = wordlist

    /*
     WordApiCaller.myWordRead() { status in
       let status = Int(result!.result_code)
       switch status {
       case 200:
         print("\(place_id) and \(index)")
       default:
         print("hello")
       }
     }
    
    */
  }

  // init(){
  // api/myWord/{id} **여기서 id는 user의 id (Integer),  "word_folder_id": 2

  // }
}
