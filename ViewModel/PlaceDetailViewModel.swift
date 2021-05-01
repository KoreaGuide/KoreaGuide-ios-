//
//  PlaceDetailViewModel.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/29.
//

import Foundation
import IGListKit
final class PlaceDetail: ListDiffable {
  let place_id: Int
  let image : ImageViewModel
  let posting : PostingViewModel
  let map : MapViewModel
  let header : PlaceDetailHeaderViewModel
  func diffIdentifier() -> NSObjectProtocol {
    return "PlaceDetail" as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? PlaceDetail else { return false }
    return place_id == object.place_id
  }

  init(place_id: Int, placeDetail: PlaceDetailModel) {
    self.place_id = place_id
    self.image = ImageViewModel(placeDetail: placeDetail)
    self.posting = PostingViewModel(placeDetail: placeDetail)
    self.map = MapViewModel(placeDetail: placeDetail)
    self.header = PlaceDetailHeaderViewModel(placeDetail: placeDetail)
  }
}
final class PlaceDetailHeaderViewModel: ListDiffable {
  let place_title: String
  func diffIdentifier() -> NSObjectProtocol {
    return "PlaceDetailHeader" as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? PlaceDetailHeaderViewModel else { return false }
    return place_title == object.place_title
  }

  init(placeDetail: PlaceDetailModel) {
    self.place_title = placeDetail.data.title
  }
}

final class PostingAll: ListDiffable {
  let place_status: String
  let title: String
  let address: String
  let first_image: String
  let first_image2: String
  let map_x: Float
  let map_y: Float
  let overview_Eng: String
  let overview_Kor: String
  let category1: String
  let category2: String
  let category3: String
  func diffIdentifier() -> NSObjectProtocol {
    return "PostingAll" as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? PostingAll else { return false }
    return place_status == object.place_status
  }

  init(placeDetail: PlaceDetailModel) {
    place_status = placeDetail.data.place_status
    title = placeDetail.data.title
    address = placeDetail.data.address
    first_image = placeDetail.data.first_image
    first_image2 = placeDetail.data.first_image2
    map_x = Float(placeDetail.data.map_x) ?? 0
    map_y = Float(placeDetail.data.map_y) ?? 0
    overview_Eng = placeDetail.data.overview_english
    overview_Kor = placeDetail.data.overview_korean
    category1 = placeDetail.data.category1
    category2 = placeDetail.data.category2
    category3 = placeDetail.data.category3
  }
}

final class PostingKor: ListDiffable {
  let place_status: String
  let title: String
  let content_id: Int
  let area_code: Int
  let address1: String
  let address2: String
  let first_image: String
  let first_image2: String
  let map_x: Float
  let map_y: Float
  let overview_Kor: String
  let category1: String
  let category2: String
  let category3: String

  func diffIdentifier() -> NSObjectProtocol {
    return "PostingKor" as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? PostingKor else { return false }
    return place_status == object.place_status && content_id == object.content_id
  }

  init(placeDetail: placeDetailKorModel) {
    place_status = placeDetail.data.place_status
    title = placeDetail.data.title
    content_id = placeDetail.data.content_id
    area_code = placeDetail.data.area_code
    address1 = placeDetail.data.address1
    address2 = placeDetail.data.address2
    first_image = placeDetail.data.first_image
    first_image2 = placeDetail.data.first_image2
    map_x = Float(placeDetail.data.map_x) ?? 0
    map_y = Float(placeDetail.data.map_y) ?? 0
    overview_Kor = placeDetail.data.overview_korean
    category1 = placeDetail.data.category1
    category2 = placeDetail.data.category2
    category3 = placeDetail.data.category3
  }
}

final class PostingEng: ListDiffable {
  let place_status: String
  let title: String
  let content_id: Int
  let area_code: Int
  let address1: String
  let address2: String
  let first_image: String
  let first_image2: String
  let map_x: Float
  let map_y: Float
  let overview_Eng: String
  let category1: String
  let category2: String
  let category3: String
  func diffIdentifier() -> NSObjectProtocol {
    return "PostingEng" as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? PostingEng else { return false }
    return place_status == object.place_status && content_id == object.content_id
  }

  init(placeDetail: placeDetailEngModel) {
    place_status = placeDetail.data.place_status
    title = placeDetail.data.title
    content_id = placeDetail.data.content_id
    area_code = placeDetail.data.area_code
    address1 = placeDetail.data.address1
    address2 = placeDetail.data.address2
    first_image = placeDetail.data.first_image
    first_image2 = placeDetail.data.first_image2
    map_x = Float(placeDetail.data.map_x) ?? 0
    map_y = Float(placeDetail.data.map_y) ?? 0
    overview_Eng = placeDetail.data.overview_english
    category1 = placeDetail.data.category1
    category2 = placeDetail.data.category2
    category3 = placeDetail.data.category3
  }
}

final class MapViewModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return "Map" as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? MapViewModel else { return false }
    return map_x == object.map_x && map_y == object.map_y
  }

  let map_x: Float
  let map_y: Float
  let address: String!
  
  init(placeDetail: PlaceDetailModel) {
    map_x = Float(placeDetail.data.map_x) ?? 0
    map_y = Float(placeDetail.data.map_y) ?? 0
    address = placeDetail.data.address
  }
}

final class ImageViewModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return "Posting_Image" as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? ImageViewModel else { return false }
    return first_image == object.first_image && first_image2 == object.first_image2
  }

  let first_image: String
  let first_image2: String

  init(placeDetail: PlaceDetailModel) {
    first_image = placeDetail.data.first_image
    first_image2 = placeDetail.data.first_image2
  }
}


final class PostingViewModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return "PostingViewModel" as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? PostingViewModel else { return false }
    return title == object.title
  }

  let title: String
  let overview_Eng: String
  let overview_Kor: String

  init(placeDetail: PlaceDetailModel) {
    title = placeDetail.data.title
    overview_Eng = placeDetail.data.overview_english
    overview_Kor = placeDetail.data.overview_korean
  }
  
}
