//
//  WordMainViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/28.
//

import Combine
import Foundation

class WordMainViewModel: ObservableObject {
  @Published var added_word_info: MainWordListModel?
  @Published var learning_word_info: MainWordListModel?
  @Published var complete_word_info: MainWordListModel?

  func setting() {
    WordApiCaller.folderWordRead(word_folder_id: 1) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        self.added_word_info = result! as MainWordListModel
      default:
        print("----- folder word read api error")
      }
    }

    WordApiCaller.folderWordRead(word_folder_id: 2) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        self.learning_word_info = result! as MainWordListModel
      default:
        print("----- folder word read api error")
      }
    }

    WordApiCaller.folderWordRead(word_folder_id: 3) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        self.complete_word_info = result! as MainWordListModel
      default:
        print("----- folder word read api error")
      }
    }
  }
}
