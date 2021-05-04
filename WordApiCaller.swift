//
//  WordApiCaller.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/05/03.
//

import Alamofire
import Foundation

final class WordApiCaller {
  static var baseHostName = "http://localhost:8080"
  static var defaultHeaders: HTTPHeaders = ["Content-Type": "application/json", "Authorization": "Bearer \(UserDefaults.token ?? "no_value")"]
  static var formdataHeaders: HTTPHeaders = ["Content-Type": "multipart/form-data", "Authorization": "Bearer \(UserDefaults.token ?? "no_value")"]
  // static var defaultHeaders: HTTPHeaders = ["Content-Type": "application/json"]
  // static var formdataHeaders: HTTPHeaders = ["Content-Type": "multipart/form-data"]
  enum Router: URLRequestConvertible {
    case homeRead
    case myWordCreate(word_id: Int)
    case oneWordRead(word_id: Int)
    case folderWordRead(word_folder_id: Int)
    case myWordDelete(word_folder_id: Int, word_id: Int)
    case placeDetailAllRead(place_id: Int)
    case placeRelatedWords(place_id: Int)

    func asURLRequest() throws -> URLRequest {
      let result: (path: String, parameters: Parameters, method: HTTPMethod, headers: HTTPHeaders) = {
        switch self {
        case let .placeRelatedWords(place_id):
          return ("/api/place/word/\(place_id)", ["": ""], .get, defaultHeaders)
        case let .placeDetailAllRead(place_id):
          return ("/api/place/detail/\(place_id)", ["": ""], .get, defaultHeaders)
        case .homeRead:
          return ("/api/home/", ["": ""], .get, defaultHeaders)
        case let .myWordCreate(word_id):
          return ("/api/myWord/" + String(UserDefaults.id!), ["data": ["word_id": word_id]], .post, defaultHeaders)
        case let .oneWordRead(word_id):// 이거 어케함
          return ("/api/word/\(word_id)", ["": ""], .get, defaultHeaders)
        case let .folderWordRead(word_folder_id: word_folder_id):
          return ("/api/myWord/\(word_folder_id)" + String(UserDefaults.id!), ["": ""], .get, defaultHeaders)
        case let .myWordDelete(word_folder_id, word_id):
          return ("/api/myWord/" + String(UserDefaults.id!), ["data": ["word_folder_id": word_folder_id, "word_id": word_id]], .delete, defaultHeaders)
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

  static func placeDetailAllRead(place_id: Int, callback: @escaping (PlaceDetailModel?) -> Void) {
    AF.request(Router.placeDetailAllRead(place_id: place_id))
      .responseJSON { response in
        debugPrint(response)
        switch response.result {
        case .failure:
          callback(nil)
          return
        case .success:
          print("@@ success")
        }
        guard let data = response.data else {
          print("@@")
          return
        }
        let decoder = JSONDecoder()
        do {
          let result = try decoder.decode(PlaceDetailModel.self, from: data)
          print("@@")
          print(result)
          callback(result)
        } catch {
          print("@@@")
          callback(nil)
        }
      }
  }

  static func placeRelatedWords(place_id: Int, callback: @escaping (WordOfPlaceModel?) -> Void) {
    AF.request(Router.placeRelatedWords(place_id: place_id))
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
          let result = try decoder.decode(WordOfPlaceModel.self, from: data)
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

  static func myWordCreate(word_id: Int, callback: @escaping (Int?) -> Void) {
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

  static func oneWordRead(word_id: Int, callback: @escaping (TodayWordModel?) -> Void) {
    AF.request(Router.oneWordRead(word_id: word_id))
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
          let result = try decoder.decode(TodayWordModel.self, from: data)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }

  static func folderWordRead(word_folder_id: Int, callback: @escaping (MainWordListModel?) -> Void) {
    AF.request(Router.folderWordRead(word_folder_id: word_folder_id))
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
          let result = try decoder.decode(MainWordListModel.self, from: data)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }
  
  static func myWordDelete(word_folder_id: Int, word_id: Int, callback: @escaping (DeleteResponse?) -> Void) {
    AF.request(Router.myWordDelete(word_folder_id: word_folder_id, word_id: word_id))
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
          let result = try decoder.decode(DeleteResponse.self, from: data)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }
}
