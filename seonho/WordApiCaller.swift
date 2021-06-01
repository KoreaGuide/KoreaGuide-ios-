//
//  WordApiCaller.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/05/03.
//

import Alamofire
import Foundation
import Combine
import UIKit

final class WordApiCaller {
  static var baseHostName = "http://localhost:8080"
  static var defaultHeaders: HTTPHeaders = ["Content-Type": "application/json"]
  static var formdataHeaders: HTTPHeaders = ["Content-Type": "multipart/form-data"]
  enum Router: URLRequestConvertible {
    case homeRead

    case myWordCreate(word_folder_id: Int, word_id: Int)
    case myWordDelete(word_folder_id: Int, word_id: Int)
    
    case userFolderRead
    
    case oneWordRead(word_id: Int)
    
    case folderWordRead(word_folder_id: Int)

    case placeDetailAllRead(place_id: Int)
    case placeRelatedWords(place_id: Int)

    case testingMatchWords(quiz_type: String, folder_id: Int)
    case testingEasySpellingWords(folder_id: Int)
    case testingHardSpellingWords(folder_id: Int)

    case testResultPost(word_id: Int, original_folder_id: Int, final_folder_id: Int, result_status: String)

    case learningWords(word_folder_id: Int)

    func asURLRequest() throws -> URLRequest {
      let result: (path: String, parameters: Parameters, method: HTTPMethod, headers: HTTPHeaders) = {
        switch self {
        case let .placeRelatedWords(place_id):
          return ("/api/place/wordList/\(UserDefaults.id!)/\(place_id)", ["": ""], .get, defaultHeaders)
        case let .placeDetailAllRead(place_id):
          return ("/api/place/detail/\(UserDefaults.id!)/\(place_id)", ["": ""], .get, defaultHeaders)
        case .homeRead:
          return ("/api/home/", ["": ""], .get, defaultHeaders)
        
        case .userFolderRead:
          return ("/api/myWordFolder/\(UserDefaults.id!)", ["": ""], .get, defaultHeaders)

        case let .oneWordRead(word_id):
          return ("/api/word/\(word_id)", ["": ""], .get, defaultHeaders)
        // return ("/api/word/", ["data" : ["word_id": word_id]], .get, defaultHeaders)
        
        case let .folderWordRead(word_folder_id):
          return ("/api/myWord/\(UserDefaults.id!)/\(word_folder_id)", ["": ""], .get, defaultHeaders)
        
        case let .myWordCreate(word_folder_id, word_id):
          return ("/api/myWord/\(UserDefaults.id!)", ["data": ["word_folder_id": word_folder_id, "word_id": word_id]], .post, defaultHeaders)
        case let .myWordDelete(word_folder_id, word_id):
          return ("/api/myWord/" + String(UserDefaults.id!), ["data": ["word_folder_id": word_folder_id, "word_id": word_id]], .delete, defaultHeaders)

        case let .testingMatchWords(quiz_type, folder_id):
          return ("/api/quiz/\(UserDefaults.id!)", ["data": ["quiz_type": quiz_type, "folder_id": folder_id]], .post, defaultHeaders)
        case let .testingEasySpellingWords(folder_id):
          return ("/api/quiz/\(UserDefaults.id!)", ["data": ["quiz_type": "SPELLING_E", "folder_id": folder_id]], .post, defaultHeaders)
        case let .testingHardSpellingWords(folder_id):
          return ("/api/quiz/\(UserDefaults.id!)", ["data": ["quiz_type": "SPELLING_H", "folder_id": folder_id]], .post, defaultHeaders)

        case let .testResultPost(word_id, original_folder_id, final_folder_id, result_status):
          return ("/api/quiz/result/\(UserDefaults.id!)", ["data": ["quiz_results": [["word_id": word_id, "original_folder_id": original_folder_id, "final_folder_id": final_folder_id, "result_status": result_status]]]], .post, defaultHeaders)

        case let .learningWords(word_folder_id):
          return ("api/myWordFolder/learnWord/\(UserDefaults.id!)/\(word_folder_id)", ["": ""], .get, defaultHeaders)
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

  static func userFolderRead(callback: @escaping (AllFolderInfo?) -> Void) {
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
          let result = try decoder.decode(AllFolderInfo.self, from: data)
          print(result)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }

//  static func placeDetailAllRead(place_id: Int, callback: @escaping (PlaceDetailModel?) -> Void) {
//    AF.request(Router.placeDetailAllRead(place_id: place_id))
//      .responseJSON { response in
//        debugPrint(response)
//        switch response.result {
//        case .failure:
//          callback(nil)
//          return
//        case .success:
//          break
//        }
//        guard let data = response.data else {
//          return
//        }
//        let decoder = JSONDecoder()
//        do {
//          let result = try decoder.decode(PlaceDetailModel.self, from: data)
//          print(result)
//          callback(result)
//        } catch {
//          callback(nil)
//        }
//      }
//  }

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

  //add specific word to user word folder
  static func myWordCreate(word_folder_id: Int, word_id: Int, callback: @escaping (AddResponse?) -> Void) {
    AF.request(Router.myWordCreate(word_folder_id: word_folder_id, word_id: word_id))
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
          let result = try decoder.decode(AddResponse.self, from: data)
          callback(result)
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

  static func testingMatchWords(quiz_type: String, folder_id: Int, callback: @escaping (WordFolderMatchTestModel?) -> Void) {
    AF.request(Router.testingMatchWords(quiz_type: quiz_type, folder_id: folder_id))
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
          let result = try decoder.decode(WordFolderMatchTestModel.self, from: data)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }

  static func testingEasySpellingWords(folder_id: Int, callback: @escaping (WordFolderEasySpellingTestModel?) -> Void) {
    AF.request(Router.testingEasySpellingWords(folder_id: folder_id))
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
          let result = try decoder.decode(WordFolderEasySpellingTestModel.self, from: data)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }

  static func testinHardSpellingWords(folder_id: Int, callback: @escaping (WordFolderHardSpellingTestModel?) -> Void) {
    AF.request(Router.testingHardSpellingWords(folder_id: folder_id))
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
          let result = try decoder.decode(WordFolderHardSpellingTestModel.self, from: data)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }

//  private func _testResultPost(word_id: Int, original_folder_id: Int, final_folder_id: Int, result_status: String, session: URLSession = URLSession.shared) throws -> URLSession.DataTaskPublisher {
//    let request = try Router.testResultPost(word_id: word_id, original_folder_id: original_folder_id, final_folder_id: final_folder_id, result_status: result_status).asURLRequest()
//    return session.dataTaskPublisher(for: request)
//  }
//
//  func testResultPost(word_id: Int, original_folder_id: Int, final_folder_id: Int, result_status: String) -> AnyPublisher<WordResultPostModel, Error>? {
//    let decoder = JSONDecoder()
//    return try? _testResultPost(word_id: Int, original_folder_id: Int, final_folder_id: Int, result_status: String)
//      .tryMap { try validate($0.data, $0.response) }
//      .decode(type: WordResultPostModel.self, decoder: decoder)
//      .eraseToAnyPublisher()
//  }

  
  static func testResultPost(word_id: Int, original_folder_id: Int, final_folder_id: Int, result_status: String, callback: @escaping (WordResultPostModel?) -> Void) {
    AF.request(Router.testResultPost(word_id: word_id, original_folder_id: original_folder_id, final_folder_id: final_folder_id, result_status: result_status))
      .responseJSON { response in
        debugPrint(response)
        switch response.result {
        case .failure:
          callback(nil)
          return
        case .success:
          break
        }
      }
  }

  static func learningWords(word_folder_id: Int, callback: @escaping (WordFolderLearnModel?) -> Void) {
    AF.request(Router.learningWords(word_folder_id: word_folder_id))
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
          let result = try decoder.decode(WordFolderLearnModel.self, from: data)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }
}
