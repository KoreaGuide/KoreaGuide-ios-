//
//  ApiHelper2.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/06.
//

import Foundation
import Alamofire

final class ApiHelper2 {
    static var baseHostName = "http://localhost:8080"
    static var defaultHeaders: HTTPHeaders = ["Content-Type": "application/json", "Authorization": "Bearer \(UserDefaults.token ?? "no_value")"]
    static var formdataHeaders: HTTPHeaders = ["Content-Type": "multipart/form-data", "Authorization": "Bearer \(UserDefaults.token ?? "no_value")"]

    enum Router2 : URLRequestConvertible {
        func asURLRequest() throws -> URLRequest {
            <#code#>
        }
        
        case getWord
    }

    static func getWord()  {
        
    }
}
