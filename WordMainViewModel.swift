//
//  WordMainViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/28.
//

import Combine
import Foundation

class WordMainViewModel: ObservableObject {
  @Published var added_word_info: MainWordCountModel?
  @Published var learning_word_info: MainWordCountModel?
  @Published var complete_word_info: MainWordCountModel?
  @Published var totalcount: Int?

  init() {
    WordApiCaller.folderWordRead(word_folder_id: 1) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        self.added_word_info = result! as MainWordCountModel
      default:
        print("----- folder word read api error")
      }
    }

    WordApiCaller.folderWordRead(word_folder_id: 2) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        self.learning_word_info = result! as MainWordCountModel
      default:
        print("----- folder word read api error")
      }
    }

    WordApiCaller.folderWordRead(word_folder_id: 3) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        self.complete_word_info = result! as MainWordCountModel
      default:
        print("----- folder word read api error")
      }
    }
  }
  
  func setting(){
    //self.totalcount = added_word_info?.data.now_word_count + learning_word_info?.data.now_word_count + complete_word_info?.data.now_word_count
  }
  
  /*
   func setting() {
     WordApiCaller.folderWordRead(word_folder_id: 1) { result in
       let status = Int(result!.result_code)
       switch status {
       case 200:
         self.added_word_info = result! as MainWordCountModel
       default:
         print("----- folder word read api error")
       }
     }

     WordApiCaller.folderWordRead(word_folder_id: 2) { result in
       let status = Int(result!.result_code)
       switch status {
       case 200:
         self.learning_word_info = result! as MainWordCountModel
       default:
         print("----- folder word read api error")
       }
     }

     WordApiCaller.folderWordRead(word_folder_id: 3) { result in
       let status = Int(result!.result_code)
       switch status {
       case 200:
         self.complete_word_info = result! as MainWordCountModel
       default:
         print("----- folder word read api error")
       }
     }
   }*/
}
