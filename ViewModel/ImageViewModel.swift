//
//  CardViewModel.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/27.
//

import Foundation
import IGListKit

class ImageViewModel: ListDiffable {
  let imageURL:String
  init (url:String) {
    self.imageURL = url
  }
}

extension ImageViewModel {
  func diffIdentifier() -> NSObjectProtocol {
    return "image" as NSObjectProtocol
  }
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let right = object as? ImageViewModel else {
      return false
    }
    return self.imageURL == right.imageURL
  }
}
