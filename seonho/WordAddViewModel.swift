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

  @Published var added_word_id_list: [Int] = []
  @Published var added_word_bool_list: [Bool] = []
  
  @Published var totalWordCount: Int = 1
  // 1~ -> index naming
  @Published var currentWordCount: Int = 0 {
    willSet {
      progressValue = Float(newValue) / Float(totalWordCount)
      self.currentWordCountforShow = newValue + 1
      
      if (newValue == self.totalWordCount - 1) && (self.currentWordCount < newValue) {
        self.currentWordCountforShow = self.totalWordCount
      }
      else if (newValue == self.totalWordCount - 2) && (self.currentWordCount > newValue){
        self.currentWordCountforShow = newValue + 1
      }
      
    }
  }
  @Published var currentWordCountforShow: Int = 0

  @Published var progressValue: Float = 0.0

  @Published var finish: Bool = false{
    willSet{
      self.currentWordCountforShow = self.totalWordCount
    }
  }
  
  @State var count = 0
  @State var existcount = 0
  
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
    totalWordCount = word_list.count
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
    
    self.added_word_bool_list.reserveCapacity(100)

    for _ in 0..<100 {
      self.added_word_bool_list.append(false)
    }
    
  }

  func wordAdd() {
   
    for word_id in added_word_id_list {
      WordApiCaller.myWordCreate(word_folder_id: UserDefaults.add_folder_id ?? 1, word_id: word_id) { result in
        let status = Int(result!.result_code)
        switch status {
        case 200:
          self.count = self.count + 1
          print("----- place related word add api done")
        case 409:
          self.existcount = self.existcount + 1
          print("----- place related word add api already exists")
        default:
          print("----- place related word add api error")
        }
      }
    }
   
    print("-----total added words count" + String(added_word_id_list.count))
    
    self.progressValue = 1.0

  
  }

  func add(word_id: Int) {
    WordApiCaller.myWordCreate(word_folder_id: UserDefaults.add_folder_id ?? 1, word_id: word_id) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        print("----- place related word add api done")
      default:
        print("----- place related word add api error")
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
