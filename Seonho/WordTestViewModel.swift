//
//  WordTestViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/26.
//

import Foundation
import Combine

class WordTestViewModel: ObservableObject {
  @Published var placeTitle: String = "place title place title"
  
  @Published var wordList: [TestWord]?
  @Published var selectedWord: TestWord?
  @Published var word_id: Int = 0
  @Published var didSelectWord: Bool = false
  
  @Published var totalWordCount: Int = 3// 1~
  @Published var currentWordCount: Int = 0// 1~ -> index naming
  @Published var progressValue: Float = 0.5
 
  
  private var cancellable: Set<AnyCancellable> = []

  }


