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
  @Published var wordlist: [RawWord]?
  @Published var selectedWord: RawWord?
  @Published var didSelectWord: Bool = false
  @Published var word_id: Int = 0
  
  
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
        if $0 != nil { return $0!.word_id } else { return 0 }
      }
      .receive(on: RunLoop.main)
      .assign(to: \.word_id, on: self)
      .store(in: &cancellable)
  }
}
