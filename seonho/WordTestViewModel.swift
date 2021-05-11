//
//  WordTestViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/26.
//

import Combine
import Foundation

class WordTestViewModel: ObservableObject {
  @Published var quiz_type: String
  @Published var word_folder_id: Int

  @Published var test_word_info: TestWordInfo?

  @Published var choice: Int = -1

  var result: [(Int, Int, Bool)] = [] // 순서, word id, correct or not

  @Published var didSelectWord: Bool = false

  @Published var totalWordCount: Int = 1 // 1~
  @Published var currentWordCount: Int = 0 {
    willSet {
      progressValue = Float(newValue) / Float(totalWordCount)
    }
  }

  @Published var progressValue: Float = 0.0
  @Published var finish: Bool = false

  private var cancellable: Set<AnyCancellable> = []

  init(quiz_type: String, word_folder_id: Int) {
    self.quiz_type = quiz_type
    self.word_folder_id = word_folder_id

    WordApiCaller.testingWords(quiz_type: quiz_type, folder_id: word_folder_id) { result in

      let status = Int(result?.result_code ?? 0)
      switch status {
      case 200:
        self.test_word_info = result?.data
        // print(result?.data.quiz_list[0].selected_word)
        // print(result?.data.quiz_list[0].word_choice_list)
        print("----- test word get api done")
      default:
        print("----- test word get api error")
      }
      self.totalWordCount = self.test_word_info?.quiz_list.count ?? 0
    }
  }
}
