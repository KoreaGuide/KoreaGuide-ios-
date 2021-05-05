//
//  UserDefaultsExtensions.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/12.
//

import Foundation

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
