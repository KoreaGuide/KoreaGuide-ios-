//
//  WordListViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/25.
//

import Foundation
import Combine
import SwiftUI

class WordListViewModel: ObservableObject {
  @Published var words: [WordInfo] = [WordInfo(word: "첫번째 단어", meaning: "first word", wordId: 1), WordInfo(word: "두번째 단어", meaning: "second word", wordId: 2), WordInfo(word: "세번째 단어", meaning: "third word", wordId: 3)]
  @Published var selectedWord: WordInfo?
  @Published var didSelectWord: Bool = false
  @Published var wordId: Int = 0
  private var cancellable: Set<AnyCancellable> = []

  private var didSelectWordPublisher: AnyPublisher<Bool, Never> {
    $selectedWord
      .map { $0 != nil }
      .eraseToAnyPublisher()
  }

  init() {
    didSelectWordPublisher
      .receive(on: RunLoop.main)
      .assign(to: \.didSelectWord, on: self)
      .store(in: &cancellable)

    $selectedWord
      .map {
        if $0 != nil { return $0!.wordId } else { return 0 }
      }
      .receive(on: RunLoop.main)
      .assign(to: \.wordId, on: self)
      .store(in: &cancellable)
  }
}
