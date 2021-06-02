//
//  WordTestViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/26.
//

import Combine
import Foundation

class WordTestSceneViewModel: ObservableObject {
  @Published var quiz_type: String
  @Published var word_folder_id: Int

  @Published var test_word_info: TestWordInfo?
  @Published var test_easy_spelling_word_info: EasySpellingTestWordInfo?
  @Published var test_hard_spelling_word_info: HardSpellingTestWordInfo?

  @Published var choice: Int = -1
  @Published var answer: String = ""
  
  var result: [(Int, Int, Bool)] = [] // 순서, word id, correct or not

  @Published var didSelectWord: Bool = false

  @Published var totalWordCount: Int = 1 // 1~
  @Published var currentWordCount: Int = 0 {
    willSet {
      progressValue = Float(newValue) / Float(totalWordCount)
      if totalWordCount - 1 == newValue {
        endOfTest = true
        //progressValue = 1.0
      }
//      else if totalWordCount == newValue {
//        endOfTest = true
//        currentWordCount = totalWordCount - 1
//        //progressValue = 1.0
//      }
      
    }
  }

  @Published var correctCount: Int = 0
  @Published var incorrectCount: Int = 0
  
  @Published var endOfTest: Bool = false

  @Published var progressValue: Float = 0.0
  @Published var finish: Bool = false

  @Published var showPopup: Bool = false

  @Published var playing: Bool = false
  
  @Published var chosen_answer: [String] = []
  
  @Published var result_list: [PostResultModel] = []
  
  private var cancellable: Set<AnyCancellable> = []

  func getSpellingCount() -> Int {
    return test_easy_spelling_word_info?.quiz_list[currentWordCount].selected_word.word_kor.count ?? 0
  }

  func postTestResult() {
    
    for r in result {
      if self.word_folder_id == UserDefaults.add_folder_id {
        var post_result: PostResultModel = PostResultModel(word_id: r.1, original_folder_id: word_folder_id, final_folder_id: ((r.2 == true ? UserDefaults.complete_folder_id : UserDefaults.learning_folder_id) ?? 0), result_status:  r.2 == true ? "CORRECT" : "WRONG")
                       
        result_list.append(post_result)
        
//        WordApiCaller.testResultPost(word_id: r.1, original_folder_id: word_folder_id, final_folder_id: (r.2 == true ? UserDefaults.complete_folder_id : UserDefaults.learning_folder_id) ?? 0, result_status: r.2 == true ? "CORRECT" : "WRONG")  { result in
//          let status = Int(result!.result_code)
//          switch status {
//          case 200:
//            print("----- word test result post api done")
//          case 204:
//            print("@@@")
//          default:
//            print("----- word test result post api error")
//          }
//        }
      }
      else if self.word_folder_id == UserDefaults.learning_folder_id {
        var post_result: PostResultModel = PostResultModel(word_id: r.1, original_folder_id: word_folder_id, final_folder_id: (r.2 == true ? UserDefaults.complete_folder_id : UserDefaults.learning_folder_id) ?? 0, result_status: r.2 == true ? "CORRECT" : "WRONG")
                       
        result_list.append(post_result)
        
//        WordApiCaller.testResultPost(word_id: r.1, original_folder_id: word_folder_id, final_folder_id: (r.2 == true ? UserDefaults.complete_folder_id : UserDefaults.learning_folder_id) ?? 0, result_status: r.2 == true ? "CORRECT" : "WRONG")  { result in
//          let status = Int(result!.result_code)
//          switch status {
//          case 200:
//            print("----- word test result post api done")
//          case 204:
//            print("@@@")
//          default:
//            print("----- word test result post api error")
//          }
//        }
      }
      else if self.word_folder_id == UserDefaults.complete_folder_id {
        var post_result: PostResultModel = PostResultModel(word_id: r.1, original_folder_id: word_folder_id, final_folder_id: (r.2 == true ? UserDefaults.complete_folder_id : UserDefaults.learning_folder_id) ?? 0, result_status: r.2 == true ? "CORRECT" : "WRONG")
                       
        result_list.append(post_result)
        
//        WordApiCaller.testResultPost(word_id: r.1, original_folder_id: word_folder_id, final_folder_id: (r.2 == true ? UserDefaults.complete_folder_id : UserDefaults.learning_folder_id) ?? 0, result_status: r.2 == true ? "CORRECT" : "WRONG")  { result in
//          let status = Int(result!.result_code)
//          switch status {
//          case 200:
//            print("----- word test result post api done")
//          case 204:
//            print("@@@")
//          default:
//            print("----- word test result post api error")
//          }
//        }
      }
      else{
        
      }
      
      WordApiCaller.testResultPost(result_list: result_list)  { result in
        let status = Int(result!.result_code)
        switch status {
        case 200:
          print("----- word test result post api done")
        case 204:
          print("@@@")
        default:
          print("----- word test result post api error")
        }
      }
        
    }
  }
  
  init(quiz_type: String, word_folder_id: Int) {
    self.quiz_type = quiz_type
    self.word_folder_id = word_folder_id

    switch quiz_type {
    case "MATCH":
      WordApiCaller.testingMatchWords(quiz_type: quiz_type, folder_id: word_folder_id) { result in

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
    case "LISTEN":
      WordApiCaller.testingMatchWords(quiz_type: quiz_type, folder_id: word_folder_id) { result in

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
    case "SPELLING_E":
      WordApiCaller.testingEasySpellingWords(folder_id: word_folder_id) { result in
        let status = Int(result?.result_code ?? 0)
        switch status {
        case 200:
          self.test_easy_spelling_word_info = result?.data
          // print(result?.data.quiz_list[0].selected_word)
          // print(result?.data.quiz_list[0].word_choice_list)
          print("----- test word get api done")
        default:
          print("----- test word get api error")
        }
        self.totalWordCount = self.test_easy_spelling_word_info?.quiz_list.count ?? 0
      }
    case "SPELLING_H":
      WordApiCaller.testinHardSpellingWords(folder_id: word_folder_id) { result in
        let status = Int(result?.result_code ?? 0)
        switch status {
        case 200:
          self.test_hard_spelling_word_info = result?.data
          // print(result?.data.quiz_list[0].selected_word)
          // print(result?.data.quiz_list[0].word_choice_list)
          print("----- test word get api done")
        default:
          print("----- test word get api error")
        }
        self.totalWordCount = self.test_hard_spelling_word_info?.quiz_list.count ?? 0
      }
    default:
      WordApiCaller.testingMatchWords(quiz_type: quiz_type, folder_id: word_folder_id) { result in

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
}


struct PostResultModel: Codable {
  init(word_id:Int, original_folder_id: Int, final_folder_id: Int, result_status: String) {
    self.word_id = word_id
    self.original_folder_id = original_folder_id
    self.final_folder_id = final_folder_id
    self.result_status = result_status
  }
  var word_id: Int
  var original_folder_id: Int
  var final_folder_id: Int
  var result_status: String
}
