//
//  WordLearnViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import Combine
import Foundation

class WordLearnViewModel: ObservableObject {
  var word_folder_id: Int = 0
  var user_id: Int = UserDefaults.id!

  @Published var word_list: [InMyListWord] = [] {
    willSet {
      totalWordCount = newValue.count
    }
  }

  @Published var addButton: Bool = false

  var result: [(Int, Int, Bool)] = [] // 순서, word id, add or not

  @Published var added_word_id_list: [Int] = []
  @Published var removed_word_id_list: [Int] = []

  @Published var totalWordCount: Int = 1
  // 1~ -> index naming
  @Published var currentWordCount: Int = 0 {
    willSet {
      progressValue = Float(newValue) / Float(totalWordCount)
    }
  }

  @Published var progressValue: Float = 0.0

  @Published var finish: Bool = false
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
}
