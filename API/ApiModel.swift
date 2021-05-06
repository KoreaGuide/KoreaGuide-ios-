//
//  File.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/12.
//

import Foundation
import IGListKit
struct signUpModel: Codable {
  let result_code: Int
//
}

struct loginModel: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: login_keys
  struct login_keys: Codable {
    let id: Int
    let email: String
    let password: String
    let nickname: String
    let created_at: String
    let created_by: String
    let token: String
    let last_login_at: String
    let week_attendance: Int
    let status: String
  }
}

struct homeReadModel: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: home_keys
}

struct home_keys: Codable {
  let id: Int
  let word: String
  let word_id: Int
  let word_image: String
  let word_audio: String
  let place_list: [HomeCard]
  init(id: Int, word: String, word_id: Int, word_image: String, word_audio: String, place_list: [HomeCard]) {
    self.id = id
    self.word = word
    self.word_id = word_id
    self.word_image = word_image
    self.word_audio = word_audio
    self.place_list = place_list
  }
}

struct Word: Codable {
  let word_id: Int
  let word: String
  let word_image: String
  let word_audio: String
  init(word_id: Int, word: String, word_image: String, word_audio: String) {
    self.word_id = word_id
    self.word = word
    self.word_image = word_image
    self.word_audio = word_audio
  }
}

struct HomeCard: Codable {
  let id: Int
  let title: String
  let first_image: String
  init(id: Int, title: String, first_image: String) {
    self.id = id
    self.title = title
    self.first_image = first_image
  }
}

struct PlaceDetailModel: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: placeDetailAll
  struct placeDetailAll: Codable {
    let user_id: Int
    let place_status: String
    let id: Int
    let title: String
    let area_code: Int
    let address: String
    let first_image: String
    let first_image2: String
    let map_x: String
    let map_y: String
    let overview_korean: String
    let overview_english: String
    let category1: String
    let category2: String
    let category3: String
  }
}

struct placeDetailKorModel: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: placeDetailKor
  struct placeDetailKor: Codable {
    let user_id: Int
    let place_status: String
    let id: Int
    let title: String
    let content_id: Int
    let area_code: Int
    let address1: String
    let address2: String
    let first_image: String
    let first_image2: String
    let map_x: String
    let map_y: String
    let overview_korean: String
    let category1: String
    let category2: String
    let category3: String
  }
}

struct placeDetailEngModel: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: placeDetailEng
  struct placeDetailEng: Codable {
    let user_id: Int
    let place_status: String
    let id: Int
    let title: String
    let content_id: Int
    let area_code: Int
    let address1: String
    let address2: String
    let first_image: String
    let first_image2: String
    let map_x: String
    let map_y: String
    let overview_english: String
    let category1: String
    let category2: String
    let category3: String
  }
}

struct placeRelatedWordModel: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: relatedWordList
  struct relatedWordList: Codable {
    let user_id: Int
    let place_id: Int
    let pagination: pagination
    let word_list: wordList

    struct pagination: Codable {
      let total_pages: Int
      let total_elements: Int
      let current_page: Int
      let current_elements: Int
    }
    struct wordList: Codable {
      let word_id: Int
      let word_kor: String
      let word_eng: String
      let word_status: String
      let word_image: String
      let word_audio: String
    }
  }
}


struct placeListForRegionReadModel: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data : placeListData
}

struct placeListData: Codable {
  let user_id : Int
  let region_id : Int
  let region_color : String
  let place_list : [place]
}

struct place : Codable {
  let id : Int
  let title : String
  let address1 : String
  let first_image : String
  let first_image2 : String
  let map_x : String
  let map_y : String
  let overview : String
}

struct Region: Codable {
  let id : Int
  let areacode : Int
  let areaname_kor : String
  let areaname_eng : String
  let color : String
}
struct RegionListReadModel : Codable {
  let result_code : Int
  let status : String
  let description : String
  let data : Data1
  struct Data1: Codable {
    let region_list : [Region]
  }
}



struct properties: Codable {
  let sgg_nm : String
  let sgg_cd : String
  let color : String
}
