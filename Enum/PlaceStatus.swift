//
//  PlaceStatus.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/05/30.
//

import Foundation
enum PlaceStatus: String, Codable {
  case not = "NO_STATUS"
  case wish = "WISH_LIST"
  case been = "HAVE_BEEN_TO"
}
enum HTTPType: String {
  case post = "POST"
  case get = "GET"
  case patch = "PATCH"
  case del = "DELETE"
  case put = "PUT"
}

enum BodyType: String {
  case none
  case form_data = "form-data"
  case lengthZero
  case json = "json"

  var header: [String]? {
    switch self {
    case .form_data:
      return ["Content-Type", "multipart/form-data"]
    case .lengthZero:
      return ["Content-Length", "0"]
    case .json:
      return ["Content-Type", "application/json"]
    default:
      return nil
    }
  }
}
enum APIError: Error {
  case invalidBody
  /// baseURL과 path를 합쳐서 urlComponent를 만들 수 없을 때.
  /// urlComponent의 url이 nil일 때
  case invalidEndpoint
  case invalidURL
  case emptyData
  case invalidJSON
  /// URLResponse를 HTTPURLResponse로 바꿀 수 없을 때 throw.
  case invalidResponse
  /// 200번대가 아닐때 throw.
  case statusCode(Int)
  /// 파일 이름이 nil일 때.
  case invalidFileName
}

func validate(_ data: Data, _ response: URLResponse) throws -> Data {
  guard let httpResponse = response as? HTTPURLResponse else {
    throw APIError.invalidResponse
  }
  guard (200 ..< 300).contains(httpResponse.statusCode) else {
    throw APIError.statusCode(httpResponse.statusCode)
  }
  return data
}
