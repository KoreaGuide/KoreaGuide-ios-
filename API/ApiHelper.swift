//
//  ApiHelper.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/12.
//
//User Create, User Read, User Delete, Check Duplicate Email, Login,
import Foundation
import Alamofire
import JWTDecode

final class ApiHelper {
    static var baseHostName = "http://165.194.104.24:8080"
    //static var defaultHeaders: HTTPHeaders = ["Content-Type": "application/json", "Authorization": UserDefaults.accessToken ?? "no_value"]
    //static var formdataHeaders: HTTPHeaders = ["Content-Type": "multipart/form-data", "Authorization": UserDefaults.accessToken ?? "no_value"]
    static var defaultHeaders: HTTPHeaders = ["Content-Type": "application/json"]
    static var formdataHeaders: HTTPHeaders = ["Content-Type": "multipart/form-data"]

    enum Router: URLRequestConvertible {
        case login(email: String, password: String) //로그인
        case register(email: String, password: String, nickName: String, level: String)
        case emailCheck(email: String)
        //case confirmEmail(key: String)
        
        func asURLRequest() throws -> URLRequest {
            let result: (path: String, parameters: Parameters, method: HTTPMethod, headers: HTTPHeaders) = {
                switch self {
                case let .register(email, password, nickName, level):
                    return("/api/user", ["data":["email": email, "password":password, "nickname": nickName, "level":level]], .post, defaultHeaders)
                case let .login(email, password):
                    return ("/api/user/login",["data": ["email": email, "password":password]], .post, defaultHeaders)
                case let .emailCheck(email):
                    return ("/api/user/checkDuplicate",["data": ["email": email]], .post, defaultHeaders)
                //case let .confirmEmail(key):
                   // return ("/api/user/checkDuplicate",["email": email, "pwd":password], .post, defaultHeaders)
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
    static func register(email: String, password: String, nickName: String, level: String, callback: @escaping (Int?) -> Void) {
      AF.request(Router.register(email: email, password: password, nickName: nickName, level: level))
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
            let result = try decoder.decode(signUpModel.self, from: data)
            callback(result.result_code)
          } catch {
            callback(nil)
          }
        }
    }
    static func emailCheck(email: String, callback: @escaping (Int?) -> Void) {
      AF.request(Router.emailCheck(email: email))
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
            let result = try decoder.decode(signUpModel.self, from: data)
            callback(result.result_code)
          } catch {
            callback(nil)
          }
        }
    }
    static func login(email: String, password: String, callback: @escaping (Int?) -> Void) {
      AF.request(Router.login(email: email, password: password))
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
            let result = try decoder.decode(signUpModel.self, from: data)
            
              print("hello")
            // 헤더에서 access 토큰을 빼와서 저장해준다.
            // 헤더의 JWT를 decoding해서 정보를 저장한다.

            if let accessToken = response.response?.allHeaderFields["Authorization"] as? String {
              UserDefaults.accessToken = accessToken
              // ApiHelper는 final class이므로 값을 직접 업데이트 해줘야 한다.
              ApiHelper.defaultHeaders["Authorization"] = accessToken

              let jwt = try decode(jwt: accessToken)
              print(jwt)
              //UserDefaults.loginID = jwt.body["login_id"] as? String
              //UserDefaults.auth = jwt.body["auth"] as? Int
              //UserDefaults.entryYear = jwt.body["year"] as? Int
              UserDefaults.email = jwt.body["email"] as? String
                UserDefaults.level = jwt.body["level"] as? String
                UserDefaults.created_at = jwt.body["created_at"] as? String
                UserDefaults.created_by = jwt.body["created_by"] as? String
                UserDefaults.week_attendance = jwt.body["week_attendance"] as? String
              //UserDefaults.name = jwt.body["name"] as? String
              //UserDefaults.email = jwt.body["e"] as? Int
  //            UserDefaults.verified = jwt.body["verified"] as? String
            }

            // 헤더에서 refresh 토큰을 빼와서 저장해준다.
            //if let refreshToken = response.response?.allHeaderFields["RefreshToken"] as? String {
              //UserDefaults.refreshToken = refreshToken
            //}

            // 헤더의 JWT를 decoding해서 auth, name을 저장한다.
            callback(result.result_code)
          } catch {
            callback(nil)
          }
        }
    }
}
