//
//  WordMainViewController.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/15.
//

import Foundation
import SwiftUI
import Combine

class WordMainViewModel: ObservableObject, Identifiable {
  
  @Published var dataSource: [WordInfo] = [WordInfo(word: "test")]
  
  init(){
    
  }
}
