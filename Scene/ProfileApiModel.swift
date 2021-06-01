//
//  ProfileApiModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/06/02.
//

import Foundation


struct ProfileAttendanceModel: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: AttendanceInfo
}

struct AttendanceInfo: Codable {
  let attendance: String
 
  let week_quiz_result: [OneDayInfo]

  struct OneDayInfo: Codable {
    let date: String
    let day_of_week: String
    let total: Int
    let correct: Int
    let wrong: Int
   
  }
}
