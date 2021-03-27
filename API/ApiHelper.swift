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
    static var baseHostName = "http://localhost:8080"
    static var defaultHeaders: HTTPHeaders = ["Content-Type": "application/json", "Authorization": "Bearer \(UserDefaults.token ?? "no_value")"]
    static var formdataHeaders: HTTPHeaders = ["Content-Type": "multipart/form-data", "Authorization": "Bearer \(UserDefaults.token ?? "no_value")"]
    //static var defaultHeaders: HTTPHeaders = ["Content-Type": "application/json"]
    //static var formdataHeaders: HTTPHeaders = ["Content-Type": "multipart/form-data"]

    enum Router: URLRequestConvertible {
        case login(email: String, password: String) //로그인
        case register(email: String, password: String, nickName: String)
        case emailCheck(email: String)
        case homeRead
        case myWordCreate(word_id: String)
        case myWordRead
        case myWordDelete(word_id: String)
        case regionListRead
        
        //case confirmEmail(key: String)
        
        func asURLRequest() throws -> URLRequest {
            let result: (path: String, parameters: Parameters, method: HTTPMethod, headers: HTTPHeaders) = {
                switch self {
                case let .register(email, password, nickName):
                    return("/api/user", ["data":["email": email, "password":password, "nickname": nickName]], .post, defaultHeaders)
                case let .login(email, password):
                    let loginHeader: HTTPHeaders = ["Content-Type":"application/json","Authorization": "Bearer no_value"]
                    return ("/api/user/login",["data": ["email": email, "password":password]], .post, loginHeader)
                case let .emailCheck(email):
                    return ("/api/user/checkDuplicate",["data": ["email": email]], .post, defaultHeaders)
                case .homeRead:
                    return ("/api/home/",["":""],.get,defaultHeaders)
                case let .myWordCreate(word_id):
                    return ("/api/myWord/"+String(UserDefaults.id!),["data":["word_id":word_id]],.post,defaultHeaders)
                case .myWordRead://이거 어케함
                    return ("/api/myWord/"+String(UserDefaults.id!),["":""],.get,defaultHeaders)
                case let .myWordDelete(word_id):
                    return ("/api/myWord/"+String(UserDefaults.id!),["data":["word_id":word_id]],.delete,defaultHeaders)
                case .regionListRead:
                    return ("/api/place/regionList",["":""],.get,defaultHeaders)
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
    static func homeRead(callback: @escaping (homeReadModel?) -> Void)
    {
        AF.request(Router.homeRead)
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .failure:
                    callback(nil)
                    return
                case .success:
                    break
                }
                guard let data = response.data else {return}
                print (String(decoding: data, as: UTF8.self))
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(homeReadModel.self, from: data)
                    print(result)
                    
                    callback(result)
                    
                } catch {
                    callback(nil)
                }
            }
    }
    
    static func myWordCreate(word_id: String, callback: @escaping (Int?) -> Void) {
        AF.request(Router.myWordCreate(word_id: word_id))
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .failure:
                    callback(nil)
                    return
                case .success:
                    break
                }
                guard let data = response.data else {return}
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
    static func myWordRead(callback: @escaping (Int?) -> Void) {
        AF.request(Router.myWordRead)
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .failure:
                    callback(nil)
                    return
                case .success:
                    break
                }
                guard let data = response.data else {return}
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
    static func myWordDelete(word_id: String, callback: @escaping (Int?) -> Void) {
        AF.request(Router.myWordDelete(word_id: word_id))
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .failure:
                    callback(nil)
                    return
                case .success:
                    break
                }
                guard let data = response.data else {return}
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
    static func regionListRead(callback: @escaping (Int?) -> Void) {
        AF.request(Router.regionListRead)
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .failure:
                    callback(nil)
                    return
                case .success:
                    break
                }
                guard let data = response.data else {return}
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
    static func register(email: String, password: String, nickName: String, callback: @escaping (Int?) -> Void) {
      AF.request(Router.register(email: email, password: password, nickName: nickName))
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
          guard let data = response.data else { return }//여기 있는거 아님?
          print(String(decoding: data, as: UTF8.self))
          let decoder = JSONDecoder()
          do {
            //>???
            let login_info = try decoder.decode(loginModel.self, from: data)
            print(login_info)
            ApiHelper.defaultHeaders["Authorization"] = "Bearer \(login_info.data.token)"
            UserDefaults.id = login_info.data.id
            UserDefaults.email = login_info.data.email
            UserDefaults.created_by = login_info.data.created_by
            UserDefaults.created_at = login_info.data.created_at
            UserDefaults.token = login_info.data.token
            UserDefaults.week_attendance = login_info.data.week_attendance
            print(login_info.data.token)
            callback(login_info.result_code)
          } catch {
            do {
                let failure_info = try decoder.decode(signUpModel.self, from: data)
                print(failure_info)
                callback(failure_info.result_code)
            }catch {
                callback(nil)
            }
          }
        }
    }
}
