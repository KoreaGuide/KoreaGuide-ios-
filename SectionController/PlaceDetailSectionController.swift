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
  ListBindingSectionControllerDataSource
{
  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
    guard let placeDetail = object as? PlaceDetail else {
      return []
    }
    let result: [ListDiffable] = [placeDetail.header, placeDetail.image, placeDetail.posting, placeDetail.map]
    return result
  }

  // 이거 무조건 해줘여함.
  override init() {
    super.init()
    dataSource = self
  }

  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
    let identifier: String
    switch viewModel {
    case is PlaceDetailHeaderViewModel:
      identifier = "header"
    case is ImageViewModel:
      identifier = "image"
    case is PostingViewModel:
      identifier = "posting"
    case is MapViewModel:
      identifier = "map"
    default:
      fatalError()
    }
    guard let cell = collectionContext?.dequeueReusableCellFromStoryboard(withIdentifier: identifier, for: self, at: index) else {
      fatalError()
    }
    if let cell = cell as? PlaceHeaderCell {
      cell.delegate = self
    }
    return cell
  }

  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
    guard let width = collectionContext?.containerSize.width else {
      fatalError()
    }
    let height: CGFloat
    switch viewModel {
    case is ImageViewModel:
      height = 200

    case is PostingViewModel:
      height = 400
    case is MapViewModel:
      height = 300
    default:
      height = 55
    }
    return CGSize(width: width, height: height)
  }
}

extension PlaceDetailSectionController: HeaderCellDelegate {
  func didTab(cell: PlaceHeaderCell) {
    viewController?.navigationController?.popViewController(animated: true)
  }
}
