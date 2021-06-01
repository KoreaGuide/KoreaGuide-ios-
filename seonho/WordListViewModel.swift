//
//  WordListViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/25.
//

import Combine
import Foundation
import SwiftUI

class WordListSceneViewModel: ObservableObject {
 
  var word_folder_id: Int
  @Published var word_list: [InMyListWord]
  
  @Published var index: Int = 0

  @Published var didSelectWord: Bool = false
  @Published var selectedWord: InMyListWord?
  
  @Published var word_id: Int = 0

  @Published var showPopup: Int = -1
  
  @Published var didTapLearnButton = false
  @Published var didTapTestButton = false
  @Published var didTapBackButton = false
  
  private var cancellable: Set<AnyCancellable> = []

  init(word_folder_id: Int) {
    self.word_folder_id = word_folder_id
    self.word_list = []
    WordApiCaller.folderWordRead(word_folder_id: word_folder_id){ result in
      switch result?.result_code{
      case 200:
        self.word_list = result?.data?.my_word_list ?? []
      default:
        print("---- folder word read api error")
      }
      
    }
  }
  
  func reload() {
    
    WordApiCaller.folderWordRead(word_folder_id: self.word_folder_id){ result in
      switch result?.result_code{
      case 200:
        self.word_list = result?.data?.my_word_list ?? []
      default:
        print("---- folder word read api error")
      }
      
    }
  }
  
  func deleteWord(delete_word_id: Int){
    WordApiCaller.myWordDelete(word_folder_id: self.word_folder_id , word_id: delete_word_id) {
      result in
      let status = Int(result?.result_code ?? 500)
      switch status {
      case 200:
        print("----- my word delete api done")
      default:
        print("----- my word delete api error")
      }
    }
    reload()
  
  }
  
  func getWordById(finding_word_id: Int) -> InMyListWord {
    return self.word_list.filter { $0.id == finding_word_id }[0]
  }
}
