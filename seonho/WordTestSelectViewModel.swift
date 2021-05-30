//
//  WordTestSelectViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/28.
//

import Foundation
import Combine


class WordTestSelectSceneViewModel: ObservableObject {
  @Published var word_folder_id: Int
  @Published var word_list: [InMyListWord]
  
  
  init(word_folder_id: Int, word_list: [InMyListWord]){
    self.word_folder_id = word_folder_id
    self.word_list = word_list
  }
  
}

