//
//  WordListViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/25.
//

import Combine
import Foundation
import SwiftUI

class WordListViewModel: ObservableObject {
 
  var word_folder_id: Int
  @Published var word_list: [InMyListWord]
  @Published var index: Int = 0

  @Published var didSelectWord: Bool = false
  @Published var selectedWord: InMyListWord?
  @Published var word_id: Int = 0

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
