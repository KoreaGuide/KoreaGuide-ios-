//
//  WordAddViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/26.
//

import Combine
import Foundation
import SwiftUI

class WordAddViewModel: ObservableObject {
  var place_id: Int
  var place_title: String = ""
  var user_id: Int = UserDefaults.id!

  @Published var word_list: [WordDetail] {
    willSet {
      totalWordCount = newValue.count
    }
  }

  @Published var addButton: Bool = false

  var results: [(Int, Int, Bool)] = [] // 순서, word id, add or not

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

  init(place_id: Int) {
    self.place_id = place_id
    word_list = []
    print("----- WordAddViewModel init")
    // place id -> related word list
    WordApiCaller.placeRelatedWords(place_id: place_id) { result in
      self.word_list = result?.data.word_list ?? []
      print("---------------word list ")

//      print(self.word_list[0].word_kor)
//      print(self.word_list[1].word_kor)
//      print("---------------word list ")
//      print(self.word_list.count)
      print("---------------word list ")
    }
    // totalWordCount = word_list.count
    // place detail call -> place title
    WordApiCaller.placeDetailAllRead(place_id: place_id) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        self.place_title = result?.data.title ?? ""
      default:
        print("----- place detail all read api error")
      }
    }
  }

  func wordAddAndDelete() {
    // ForEach(added_word_id_list, id: \.self) { word_id in
    //  self.add(word_id: word_id)
    // }
  }

  func add(word_id: Int) {
    WordApiCaller.myWordCreate(word_folder_id: UserDefaults.add_folder_id ?? 1, word_id: word_id) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        print("----- today word add api done")
      default:
        print("----- today word add api error")
      }
    }
  }

  func remove(word_id: Int) {
    WordApiCaller.myWordDelete(word_folder_id: UserDefaults.add_folder_id ?? 1, word_id: word_id) {
      result in
      let status = Int(result?.result_code ?? 500)
      switch status {
      case 200:
        print("----- my word delete api done")
      default:
        print("----- my word delete api error")
      }
    }

    WordApiCaller.myWordDelete(word_folder_id: UserDefaults.learning_folder_id ?? 2, word_id: word_id) {
      result in
      let status = Int(result?.result_code ?? 500)
      switch status {
      case 200:
        print("----- my word delete api done")
      default:
        print("----- my word delete api error")
      }
    }

    WordApiCaller.myWordDelete(word_folder_id: UserDefaults.complete_folder_id ?? 3, word_id: word_id) {
      result in
      let status = Int(result?.result_code ?? 500)
      switch status {
      case 200:
        print("----- my word delete api done")
      default:
        print("----- my word delete api error")
      }
    }
  }
}
