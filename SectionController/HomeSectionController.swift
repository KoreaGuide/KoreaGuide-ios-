//
//  HomeSectionController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/27.
//

import Foundation
import IGListKit
import AVFoundation
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
    print("1")
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
    if let cell = cell as? WordCell {
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
    case is CardViewModel:
      height = 250
      
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
    self.inset = UIEdgeInsets(top:0, left:0, bottom: 30, right: 0)
    self.minimumLineSpacing = 20
    
  }
  
}

extension HomeSectionController : WordCellDelegate {
  func didTap(cell: WordCell) {
    let url = URL(string: cell.word_audio)
    var player: AVPlayer?
    var playerItem : AVPlayerItem?
    playerItem = AVPlayerItem(url: url!)
    player = AVPlayer(playerItem: playerItem)
    player!.play()
  }
}
