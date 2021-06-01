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
    case myMapRead
    case myMapWishRead
    case myMapHaveBeenRead
    case myMapCreate(place_id:Int ,status: String,diary: String?)
    case myMapDelete(place_id: Int)
    // case confirmEmail(key: String)

    func asURLRequest() throws -> URLRequest {
      let result: (path: String, parameters: Parameters, method: HTTPMethod, headers: HTTPHeaders) = {
        switch self {
        case let .myMapDelete(place_id):
          return ("/api/myMap/\(UserDefaults.id!)",["data":["place_id":place_id]],.delete,defaultHeaders)
        case let .myMapCreate(place_id, status,diary):
          return ("/api/myMap/\(UserDefaults.id!)",["data":["place_id":place_id,"place_status":status,"diary":diary ?? ""]],.post,defaultHeaders)
        case .myMapRead:
          return ("/api/myMap/all/\(UserDefaults.id!)",["":""],.get,defaultHeaders)
        case .myMapWishRead:
          return ("/api/myMap/wish/\(UserDefaults.id!)",["":""],.get,defaultHeaders)
        case .myMapHaveBeenRead:
          return ("/api/myMap/haveBeen/\(UserDefaults.id!)",["":""],.get,defaultHeaders)
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
          return ("/api/myWordFolder/", ["data": ["user_id": user_id, "folder_name": folder_name]], .post, defaultHeaders)

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
  static func uploadFile(geoJsonMap: Data, callback: @escaping (Bool) -> Void) {
    let url = "http://localhost:8080/api/myMap/upload/\(UserDefaults.id ?? 0)"
    let formdataHeaders: HTTPHeaders = ["Content-Type": "multipart/form-data"]
    AF.upload(multipartFormData: { multiPart in
      multiPart.append(geoJsonMap, withName: "file")
    }, to: url, headers: formdataHeaders)
      .uploadProgress(queue: .main, closure: {
        progress in
        print("Upload Progress: \(progress.fractionCompleted)")
      })
      .responseJSON(completionHandler: { response in
        debugPrint(response)
        guard let data = response.data else {
          return
        }
        print(String(decoding: data, as: UTF8.self))
        switch response.result {
        case .failure:
          callback(false)
        case .success:
          callback(true)
        }
      })
  }
//  static func downloadFile(callback: @escaping (Bool) -> Void ){
//    
//      let url = "http://localhost:8080/api/myMap/download/\(UserDefaults.id ?? 0)"
//      
//    let destination: DownloadRequest.Destination = { _, _ in
//             let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
//             .userDomainMask, true)[0]
//             let documentsURL = URL(fileURLWithPath: documentsPath, isDirectory: true)
//             let fileURL = documentsURL.appendingPathComponent("mapJson.geojson")
//
//             return (fileURL, [.removePreviousFile, .createIntermediateDirectories]) }
//    AF.download(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: defaultHeaders, interceptor: nil, requestModifier: nil, to: destination).downloadProgress {
//      progress in
//      
//    }.response(completionHandler: { response in
//      debugPrint(response)
//      switch response.result {
//      case .failure:
//        callback(false)
//      case .success:
//        UserDefaults.mapJson = response.fileURL
//        callback(true)
//      }
//    })
//  }
  
  static func myMapCreate(place_id: Int,status: PlaceStatus,diary: String?,callback: @escaping (response_my_map_create?) -> Void) {
    AF.request(Router.myMapCreate(place_id: place_id, status: status.rawValue, diary: diary))
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
          let result = try decoder.decode(response_my_map_create.self, from: data)
          print(result)
          callback(result)
        } catch {
          callback(nil)
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
  static func myWishRead(callback: @escaping (response_my_map_all_read?) -> Void) {
    AF.request(Router.myMapWishRead)
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
          let result = try decoder.decode(response_my_map_all_read.self, from: data)
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
          let result = try decoder.decode(RegisterResult.self, from: data)

          UserDefaults.id = result.data.id

          ApiHelper.folderCreate(user_id: UserDefaults.id ?? 0, folder_name: "ADDED") { result in
            UserDefaults.add_folder_id = result?.data.word_folder_id
          }

          ApiHelper.folderCreate(user_id: UserDefaults.id ?? 0, folder_name: "Learning") { result in
            UserDefaults.learning_folder_id = result?.data.word_folder_id
          }

          ApiHelper.folderCreate(user_id: UserDefaults.id ?? 0, folder_name: "Complete") { result in
            UserDefaults.complete_folder_id = result?.data.word_folder_id
          }

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
          print("----------")
          print(login_info)
          // ApiHelper.defaultHeaders["Authorization"] = "Bearer \(login_info.data.token)"
          UserDefaults.id = login_info.data.id
          UserDefaults.email = login_info.data.email
          UserDefaults.nickname = login_info.data.nickname
          UserDefaults.created_by = login_info.data.created_by
          UserDefaults.created_at = login_info.data.created_at
          // UserDefaults.token = login_info.data.token
          UserDefaults.week_attendance = login_info.data.week_attendance
          UserDefaults.add_folder_id = login_info.data.add_folder_id
          UserDefaults.learning_folder_id = login_info.data.learning_folder_id
          UserDefaults.complete_folder_id = login_info.data.complete_folder_id
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
        print("-----------")
        print(String(decoding: data, as: UTF8.self))
        let decoder = JSONDecoder()
        do {
          let result = try decoder.decode(Folder.self, from: data)
          print("-----------")
          print(result)
          callback(result)
        } catch {
          callback(nil)
        }
      }
  }
}
