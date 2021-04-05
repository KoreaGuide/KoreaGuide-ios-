//
//  PlaceDetailSectionController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/29.
//

import AVFoundation
import AVKit
import Foundation
import IGListKit
class PlaceDetailSectionController: ListBindingSectionController<PlaceDetail>,
                                    ListBindingSectionControllerDataSource {
  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
    guard let placeDetail = object as? PlaceDetail else {
      fatalError()
    }
    let result: [ListDiffable] = []
    return result
  }
  
  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
    <#code#>
  }
  
  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
    <#code#>
  }
  
  
  
  
}

