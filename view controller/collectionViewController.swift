//
//  collectionViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/24.
//

import Foundation
import IGListKit
import UIKit
protocol CardSectionControllerDelegate: class {
  func removeSectionControllerWantsRemoved(_ sectionController: CardSectionController)
}
class CardSectionController: ListBindingSectionController<home_keys>, ListBindingSectionControllerDataSource{
  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
    guard let card = object as? home_keys else {fatalError() }
    
    return card.place_list
  }
  
  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
    print("call sizeForViewModel")
    guar let width = collectionContext?.containerSize.width else { }
  }
  
  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
    <#code#>
  }
  
  private var cardItem: home_keys?
  override func sizeForItem(at index: Int) -> CGSize {
    return CGSize(width: collectionContext!.containerSize.width, height: 55)
  }

  override func numberOfItems() -> Int {
    return 1
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext!.dequeueReusableCellFromStoryboard(withIdentifier: "CardViewCell", for: self, at: index) as! CardViewCell
    return cell
  }

  override func didUpdate(to object: Any) {
    cardItem = object as? home_data
  }
}
