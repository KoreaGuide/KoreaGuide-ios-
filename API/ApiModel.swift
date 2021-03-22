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
      let status: String
}
struct homeReadModel: Codable {
    let result_code: Int
    let status: String
    let description: String
    let data: [home_keys]
}
struct home_keys: Codable {
    let place_id: Int
    let place_title: String
    let place_image: String
}
struct CardInfo {
    var backgroundColor: UIColor
    var height: CGFloat
    var place_id: Int
    var place_title: String
    var place_image: String
    init(_ id: Int, _ image: String,_ titleString: String,_ bgColor: UIColor,_ cellheight:CGFloat) {
        place_title = titleString
        backgroundColor = bgColor
        height = cellheight
        place_id = id
        place_image = image
    }
}
