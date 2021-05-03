//
//  WordMainViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/28.
//

import Combine
import Foundation

class WordMainViewModel: ObservableObject {
  @Published var added_word_info: MainWordCountModel
  @Published var learning_word_info: MainWordCountModel
  @Published var complete_word_info: MainWordCountModel
  
  init() {
    
  }
  
  
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

