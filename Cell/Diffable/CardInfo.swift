//
//  CardInfo.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/26.
//

import Foundation
import IGListDiffKit

final class CardInfo: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return (place_image + place_title) as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard self !== object else { return true }
    guard let object = object as? CardInfo else { return false }
    return place_title == object.place_title && place_id == object.place_id
  }
  var word_id : Int
  var word : String
  var word_image : String
  var word_audio : String
  var place_list : [places]
  init(_ id: Int, _ image: String, _ titleString: String) {
    place_list[0].title = titleString
    place_list[0].id = id
    place_list[0].first_image = image
  }
  struct places {
    var id:Int
    var title: String
    var first_image: String
  }
  
}
