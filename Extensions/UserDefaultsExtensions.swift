//
//  UserDefaultsExtensions.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/12.
//

import Foundation
import MapKit
extension UserDefaults {
  private enum Keys {
    static let email = "Email"
    static let password = "Password"
    static let token = "token"
    static let created_at = "created_at"
    static let created_by = "create_by"
    static let week_attendance = "week_attendance"
    static let id = "id"
    static let add_folder_id = "add_folder_id"
    static let learning_folder_id = "learning_folder_id"
    static let complete_folder_id = "complete_folder_id"
    static let seoul = "seoul"
    static let pusan = "pusan"
    static let deagu = "deagu"
    static let incheon = "incheon"
    static let gwangju = "gwangju"
    static let deajeon = "deajeon"
    static let ulsan = "ulsan"
    static let sejong = "sejong"
    static let gyeongi = "gyeongi"
    static let gangwon = "gangwon"
    static let chungbuk = "chungbuk"
    static let chungnam = "chungnam"
    static let jeonbuk = "jeonbuk"
    static let jeonnam = "jeonnam"
    static let gyeonbuk = "gyeonbuk"
    static let gyeonnam = "gyeonnam"
    static let jeju = "jeju"
  }

  static var placeInfo: [place] = []
  static var deajeon: String {
    get { return standard.string(forKey: Keys.deajeon) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.deajeon) }
  }

  static var ulsan: String {
    get { return standard.string(forKey: Keys.ulsan) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.ulsan) }
  }

  static var sejong: String {
    get { return standard.string(forKey: Keys.sejong) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.sejong) }
  }

  static var gyeongi: String {
    get { return standard.string(forKey: Keys.gyeongi) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.gyeongi) }
  }

  static var gangwon: String {
    get { return standard.string(forKey: Keys.gangwon) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.gangwon) }
  }

  static var chungbuk: String {
    get { return standard.string(forKey: Keys.chungbuk) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.chungbuk) }
  }

  static var chungnam: String {
    get { return standard.string(forKey: Keys.chungnam) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.chungnam) }
  }

  static var jeonbuk: String {
    get { return standard.string(forKey: Keys.jeonbuk) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.jeonbuk) }
  }

  static var jeonnam: String {
    get { return standard.string(forKey: Keys.jeonnam) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.jeonnam) }
  }

  static var gyeonnam: String {
    get { return standard.string(forKey: Keys.gyeonnam) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.gyeonnam) }
  }

  static var gyeonbuk: String {
    get { return standard.string(forKey: Keys.gyeonbuk) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.gyeonbuk) }
  }

  static var jeju: String {
    get { return standard.string(forKey: Keys.jeju) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.jeju) }
  }

  static var seoul: String {
    get { return standard.string(forKey: Keys.seoul) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.seoul) }
  }

  static var pusan: String {
    get { return standard.string(forKey: Keys.pusan) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.pusan) }
  }

  static var deagu: String {
    get { return standard.string(forKey: Keys.deagu) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.deagu) }
  }

  static var incheon: String {
    get { return standard.string(forKey: Keys.incheon) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.incheon) }
  }

  static var gwangju: String {
    get { return standard.string(forKey: Keys.gwangju) ?? "#ffffffff" }
    set { standard.set(newValue, forKey: Keys.gwangju) }
  }

  static var password: String? {
    get { return standard.string(forKey: Keys.password) }
    set { standard.set(newValue, forKey: Keys.password) }
  }

  static var email: String? {
    get { return standard.string(forKey: Keys.email) }
    set { standard.set(newValue, forKey: Keys.email) }
  }

  static var created_at: String? {
    get { return standard.string(forKey: Keys.created_at) }
    set { standard.set(newValue, forKey: Keys.created_at) }
  }

  static var created_by: String? {
    get { return standard.string(forKey: Keys.created_by) }
    set { standard.set(newValue, forKey: Keys.created_by) }
  }

  static var week_attendance: Int? {
    get { return standard.integer(forKey: Keys.week_attendance) }
    set { standard.set(newValue, forKey: Keys.week_attendance) }
  }

  static var id: Int? {
    get { return standard.integer(forKey: Keys.id) }
    set { standard.set(newValue, forKey: Keys.id) }
  }

  static var token: String? {
    get { return standard.string(forKey: Keys.token) }
    set { standard.set(newValue, forKey: Keys.token) }
  }

  static var add_folder_id: Int? {
    get { return standard.integer(forKey: Keys.add_folder_id) }
    set { standard.set(newValue, forKey: Keys.add_folder_id) }
  }

  static var learning_folder_id: Int? {
    get { return standard.integer(forKey: Keys.learning_folder_id) }
    set { standard.set(newValue, forKey: Keys.learning_folder_id) }
  }

  static var complete_folder_id: Int? {
    get { return standard.integer(forKey: Keys.complete_folder_id) }
    set { standard.set(newValue, forKey: Keys.complete_folder_id) }
  }
}

func setColor(code: String, color: String) {
  if code == "11" { // 서울
    UserDefaults.seoul = color
  } else if code == "21" { // 부산
    UserDefaults.pusan = color
  } else if code == "22" { // 대구
    UserDefaults.deagu = color
  } else if code == "23" { // 인천
    UserDefaults.incheon = color
  } else if code == "24" { // 광주
    UserDefaults.gwangju = color
  } else if code == "25" { // 대전
    UserDefaults.deajeon = color
  } else if code == "26" { // 울산
    UserDefaults.ulsan = color
  } else if code == "29" { // 세종
    UserDefaults.sejong = color
  } else if code == "31" { // 경기
    UserDefaults.gyeongi = color
  } else if code == "32" { // 강원
    UserDefaults.gangwon = color
  } else if code == "33" { // 충북
    UserDefaults.chungbuk = color
  } else if code == "34" { // 충남
    UserDefaults.chungnam = color
  } else if code == "35" { // 전북
    UserDefaults.jeonbuk = color
  } else if code == "36" { // 전남
    UserDefaults.jeonnam = color
  } else if code == "37" { // 경북
    UserDefaults.gyeonbuk = color
  } else if code == "38" { // 경남
    UserDefaults.gyeonnam = color
  } else if code == "39" { // 제주
    UserDefaults.jeju = color
  }
}

func getColor(code: String) -> String {
  if code == "11" { // 서울
    return UserDefaults.seoul
  } else if code == "21" { // 부산
    return UserDefaults.pusan
  } else if code == "22" { // 대구
    return UserDefaults.deagu
  } else if code == "23" { // 인천
    return UserDefaults.incheon
  } else if code == "24" { // 광주
    return UserDefaults.gwangju
  } else if code == "25" { // 대전
    return UserDefaults.deajeon
  } else if code == "26" { // 울산
    return UserDefaults.ulsan
  } else if code == "29" { // 세종
    return UserDefaults.sejong
  } else if code == "31" { // 경기
    return UserDefaults.gyeongi
  } else if code == "32" { // 강원
    return UserDefaults.gangwon
  } else if code == "33" { // 충북
    return UserDefaults.chungbuk
  } else if code == "34" { // 충남
    return UserDefaults.chungnam
  } else if code == "35" { // 전북
    return UserDefaults.jeonbuk
  } else if code == "36" { // 전남
    return UserDefaults.jeonnam
  } else if code == "37" { // 경북
    return UserDefaults.gyeonbuk
  } else if code == "38" { // 경남
    return UserDefaults.gyeonnam
  } else if code == "39" { // 제주
    return UserDefaults.jeju
  }
  return "#ffffffff"
}
