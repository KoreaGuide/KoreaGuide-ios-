//
//  File.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/12.
//

import Foundation
import IGListKit
struct signUpModel: Codable {
  let result_code: Int
//
}

struct loginModel: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: login_keys
  struct login_keys: Codable {
    let id: Int
    let email: String
    let password: String
    let nickname: String
    let created_at: String
    let created_by: String
    let token: String
    let last_login_at: String
    let week_attendance: Int
    let status: String
  }
}

struct homeReadModel: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: home_keys
}

struct home_keys: Codable {
  let id: Int
  let word: Word
  let place_list: [HomeCard]
  init(id: Int, word: Word, place_list: [HomeCard]) {
    self.id = id
    self.word = word
    self.place_list = place_list
  }
}

struct Word: Codable {
  let word_id: Int
  let word: String
  let word_image: String
  let word_audio: String
  init(word_id: Int, word: String, word_image: String, word_audio: String) {
    self.word_id = word_id
    self.word = word
    self.word_image = word_image
    self.word_audio = word_audio
  }
}

struct HomeCard: Codable {
  let id: Int
  let title: String
  let first_image: String
  init(id: Int, title: String, first_image: String) {
    self.id = id
    self.title = title
    self.first_image = first_image
  }
}
