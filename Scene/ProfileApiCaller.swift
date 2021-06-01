//
//  ProfileApiCaller.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/06/02.
//

import Foundation
import Alamofire
import Combine
import UIKit

final class ProfileApiCaller {
  static var baseHostName = "http://localhost:8080"
  static var defaultHeaders: HTTPHeaders = ["Content-Type": "application/json"]
  static var formdataHeaders: HTTPHeaders = ["Content-Type": "multipart/form-data"]
  enum Router: URLRequestConvertible {
    
    case attendanceInfo

    func asURLRequest() throws -> URLRequest {
      let result: (path: String, parameters: Parameters, method: HTTPMethod, headers: HTTPHeaders) = {
        switch self {
        
        case .attendanceInfo:
          return ("api/profile/\(UserDefaults.id!)", ["": ""], .get, defaultHeaders)
        }
      }()
      let url = try "\(baseHostName)".asURL()
      let urlRequest = try URLRequest(url: url.appendingPathComponent(result.path), method: result.method, headers: result.headers)

      if result.method == .get {
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
      } else {
        return try JSONEncoding.default.encode(urlRequest, with: result.parameters)
      }
    }
  }

  
  static func attendanceInfo(callback: @escaping (ProfileAttendanceModel?) -> Void) {
    AF.request(Router.attendanceInfo)
      .responseJSON { response in
        debugPrint(response)
        switch response.result {
        case .failure:
          callback(nil)
          return
        case .success:
          break
        }
        guard let data = response.data else { return }
        print(String(decoding: data, as: UTF8.self))
        let decoder = JSONDecoder()
        do {
          let result = try decoder.decode(ProfileAttendanceModel.self, from: data)
          print(result)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }
}
