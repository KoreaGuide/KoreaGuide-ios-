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
  var word_folder_name: String = ""
  var user_id: Int = UserDefaults.id!

  @Published var word_list: [LearnWord] = [] {
    willSet {
      totalWordCount = newValue.count
    }
  }

  // @Published var addButton: Bool = false

  // var result: [(Int, Int, Bool)] = [] // 순서, word id, add or not

  // @Published var added_word_id_list: [Int] = []
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
    word_list = []
    WordApiCaller.learningWords(word_folder_id: word_folder_id) { result in

      let status = Int(result?.result_code ?? 0)
      switch status {
      case 200:
        self.word_list = result?.data.word_list ?? []
        self.word_folder_name = result?.data.folder_name ?? ""

      default:
        print("-----learning words load api error")
      }
    }
  }
}
