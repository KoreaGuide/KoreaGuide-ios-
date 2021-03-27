//
//  HomeSectionController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/27.
//

import Foundation
import IGListKit

class HomeSectionController: ListBindingSectionController<Home>,
  ListBindingSectionControllerDataSource
{
  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
    guard let home = object as? Home else {
      fatalError()
    }
    let result:[ListDiffable] = [
      WordViewModel(word_id: home.word.word_id, word: home.word.word, word_image: home.word.word_image, word_audio: home.word.word_audio)
    ]
    return result + home.cards
  }
  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
    print("call cellForViewModel")
    let identifier:String
    switch viewModel {
    case is CardViewModel:
      identifier = "card"
    case is WordViewModel:
      identifier = "word"
    default:
      fatalError()
    }
    guard let cell = collectionContext?.dequeueReusableCellFromStoryboard(withIdentifier: identifier, for: self, at: index) else {
      fatalError()
    }
    return cell
  }
  
  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
    guard let width = collectionContext?.containerSize.width else {
      fatalError()
    }
    let height: CGFloat
    switch viewModel {
    case is CardViewModel:
      height = 150
    case is WordViewModel:
      height = 200
    default:
      height = 55
    }
    return CGSize(width: width, height: height)
  }
  
  override init() {
    super.init()
    dataSource = self
  }
}
