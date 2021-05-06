//
//  ApiHelper.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/12.
//
// User Create, User Read, User Delete, Check Duplicate Email, Login,
import Alamofire
import Foundation

final class ApiHelper {
  static var baseHostName = "http://localhost:8080"
//  static var defaultHeaders: HTTPHeaders = ["Content-Type": "application/json", "Authorization": "Bearer \(UserDefaults.token ?? "no_value")"]
//  static var formdataHeaders: HTTPHeaders = ["Content-Type": "multipart/form-data", "Authorization": "Bearer \(UserDefaults.token ?? "no_value")"]
  static var defaultHeaders: HTTPHeaders = ["Content-Type": "application/json"]
  static var formdataHeaders: HTTPHeaders = ["Content-Type": "multipart/form-data"]

  enum Router: URLRequestConvertible {
    case login(email: String, password: String) // 로그인
    case register(email: String, password: String, nickName: String)
    case emailCheck(email: String)
    case homeRead
    case myWordCreate(word_id: String)
    case myWordRead
    case myWordDelete(word_id: String)
    case regionListRead
    case placeDetailAllRead(place_id: Int)
    case placeDetailEngRead(place_id: Int)
    case placeDetailKorRead(place_id: Int)
    case placeRelatedWords(place_id: Int, page_num: Int)
    case placeListForRegionRead(region_id: Int)
    case folderCreate(user_id: Int, folder_name: String)
    // case confirmEmail(key: String)

    func asURLRequest() throws -> URLRequest {
      let result: (path: String, parameters: Parameters, method: HTTPMethod, headers: HTTPHeaders) = {
        switch self {
        case let .placeListForRegionRead(region_id):
          return ("/api/place/region/\(String(describing: UserDefaults.id!))/\(region_id)", ["": ""], .get, defaultHeaders)
        case let .placeRelatedWords(place_id, page_num):
          return ("/api/place/word/\(place_id)?=page=\(page_num)", ["": ""], .get, defaultHeaders)
        case let .placeDetailKorRead(place_id):
          return ("/api/place/detail/kor/\(String(describing: UserDefaults.id!))/\(place_id)", ["": ""], .get, defaultHeaders)
        case let .placeDetailEngRead(place_id):
          return ("/api/place/detail/eng/\(String(describing: UserDefaults.id!))/\(place_id)", ["": ""], .get, defaultHeaders)
        case let .placeDetailAllRead(place_id):
          return ("/api/place/detail/\(String(UserDefaults.id!))/\(place_id)", ["": ""], .get, defaultHeaders)
        case let .register(email, password, nickName):
          return ("/api/user", ["data": ["email": email, "password": password, "nickname": nickName]], .post, defaultHeaders)
        case let .login(email, password):
//          let loginHeader: HTTPHeaders = ["Content-Type": "application/json", "Authorization": "Bearer no_value"]
//          return ("/api/user/login", ["data": ["email": email, "password": password]], .post, loginHeader)
          return ("/api/user/login", ["data": ["email": email, "password": password]], .post, defaultHeaders)
        case let .emailCheck(email):
          return ("/api/user/checkDuplicate", ["data": ["email": email]], .post, defaultHeaders)
        case .homeRead:
          return ("/api/home/", ["": ""], .get, defaultHeaders)
        case let .myWordCreate(word_id):
          return ("/api/myWord/" + String(UserDefaults.id!), ["data": ["word_id": word_id]], .post, defaultHeaders)
        case .myWordRead: // 이거 어케함
          return ("/api/myWord/" + String(UserDefaults.id!), ["": ""], .get, defaultHeaders)
        case let .myWordDelete(word_id):
          return ("/api/myWord/" + String(UserDefaults.id!), ["data": ["word_id": word_id]], .delete, defaultHeaders)
        case .regionListRead:
          return ("/api/place/regionList/" + String(UserDefaults.id!), ["": ""], .get, defaultHeaders)

        case let .folderCreate(user_id: user_id, folder_name: folder_name):
          return ("/api/myWordFolder", ["data": ["user_id": user_id, "folder_name": folder_name]], .post, defaultHeaders)

          // case let .confirmEmail(key):
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

  static func placeListForRegionRead(region_id: Int, callback: @escaping (placeListForRegionReadModel?) -> Void) {
    AF.request(Router.placeListForRegionRead(region_id: region_id))
      .responseJSON { response in
        debugPrint(response)
        switch response.result {
        case .failure:
          callback(nil)
          return
        case .success:
          break
        }
        guard let data = response.data else {
          return
        }
        let decoder = JSONDecoder()
        do {
          let result = try decoder.decode(placeListForRegionReadModel.self, from: data)
          print(result)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }

  static func placeDetailAllRead(place_id: Int, callback: @escaping (PlaceDetailModel?) -> Void) {
    AF.request(Router.placeDetailAllRead(place_id: place_id))
      .responseJSON { response in
        debugPrint(response)
        switch response.result {
        case .failure:
          callback(nil)
          return
        case .success:
          break
        }
        guard let data = response.data else {
          return
        }
        let decoder = JSONDecoder()
        do {
          let result = try decoder.decode(PlaceDetailModel.self, from: data)
          print(result)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }

  static func placeDetailKorRead(place_id: Int, callback: @escaping (placeDetailKorModel?) -> Void) {
    AF.request(Router.placeDetailKorRead(place_id: place_id))
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
          let result = try decoder.decode(placeDetailKorModel.self, from: data)
          print(result)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }

  static func placeDetailEngRead(place_id: Int, callback: @escaping (placeDetailEngModel?) -> Void) {
    AF.request(Router.placeDetailEngRead(place_id: place_id))
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
          let result = try decoder.decode(placeDetailEngModel.self, from: data)
          print(result)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }

  static func placeRelatedWords(place_id: Int, page_num: Int, callback: @escaping (placeRelatedWordModel?) -> Void) {
    AF.request(Router.placeRelatedWords(place_id: place_id, page_num: page_num))
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
          let result = try decoder.decode(placeRelatedWordModel.self, from: data)
          print(result)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }

  static func homeRead(callback: @escaping (homeReadModel?) -> Void) {
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
        guard let data = response.data else { return }
        print(String(decoding: data, as: UTF8.self))
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

  static func regionListRead(callback: @escaping (RegionListReadModel?) -> Void) {
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
        guard let data = response.data else { return }
        print(String(decoding: data, as: UTF8.self))
        let decoder = JSONDecoder()
        do {
          let result = try decoder.decode(RegionListReadModel.self, from: data)
          callback(result)
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
        guard let data = response.data else { return } // 여기 있는거 아님?
        print(String(decoding: data, as: UTF8.self))
        let decoder = JSONDecoder()
        do {
          // >???
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
          } catch {
            callback(nil)
          }
        }
      }
  }

  static func folderCreate(user_id: Int, folder_name: String, callback: @escaping (Folder?) -> Void) {
    AF.request(Router.folderCreate(user_id: user_id, folder_name: folder_name))
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
          let result = try decoder.decode(Folder.self, from: data)
          print(result)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }
}
