//
//  File.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/12.
//

import Foundation

struct signUpModel: Codable {
  let result_code: Int
//
}
struct loginModel: Codable {
    let result_code: Int
      let status: String
      let description: String
      let data: login_keys
}
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
      let status: String}
