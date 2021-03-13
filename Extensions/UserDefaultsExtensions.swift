//
//  UserDefaultsExtensions.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/12.
//

import Foundation

extension UserDefaults {
    private struct Keys{
        static let email = "Email"
        static let password = "Password"
        static let accessToken = "AceessToken"
        static let level = "level"
        static let created_at = "created_at"
        static let created_by = "create_by"
        static let week_attendance = "week_attendance"
    }
    static var accessToken: String? {
      get { return standard.string(forKey: Keys.accessToken) }
      set { standard.set(newValue, forKey: Keys.accessToken) }
    }
    static var password: String? {
      get { return standard.string(forKey: Keys.password) }
      set { standard.set(newValue, forKey: Keys.password) }
    }
    static var email: String? {
      get { return standard.string(forKey: Keys.email) }
      set { standard.set(newValue, forKey: Keys.email) }
    }
    static var level: String? {
      get { return standard.string(forKey: Keys.level) }
      set { standard.set(newValue, forKey: Keys.level) }
    }
    static var created_at: String? {
      get { return standard.string(forKey: Keys.level) }
      set { standard.set(newValue, forKey: Keys.level) }
    }
    static var created_by: String? {
      get { return standard.string(forKey: Keys.level) }
      set { standard.set(newValue, forKey: Keys.level) }
    }
    static var week_attendance: String? {
      get { return standard.string(forKey: Keys.level) }
      set { standard.set(newValue, forKey: Keys.level) }
    }


}
