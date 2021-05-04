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
  var word_list_info: MainWordListModel
  var word_folder_id: Int
  @Published var word_list: [InMyListWord]

  @Published var didSelectWord: Bool = false
  @Published var selectedWord: InMyListWord?
  @Published var word_id: Int = 0

  private var cancellable: Set<AnyCancellable> = []

  init(word_folder_id: Int, word_list_info: MainWordListModel) {
    self.word_folder_id = word_folder_id
    self.word_list_info = word_list_info
    self.word_list = word_list_info.data.my_word_list
  }

  private var didSelectWordPublisher: AnyPublisher<Bool, Never> {
    $selectedWord
      .map { $0 != nil }
      .eraseToAnyPublisher()
  }

  /*
      didSelectWordPublisher
        .receive(on: RunLoop.main)
        .assign(to: \.didSelectWord, on: self)
        .store(in: &cancellable)

      $selectedWord
        .map {
          if $0 != nil { return $0!.word_id } else { return 0 }
        }
        .receive(on: RunLoop.main)
        .assign(to: \.word_id, on: self)
        .store(in: &cancellable)
   */
}
