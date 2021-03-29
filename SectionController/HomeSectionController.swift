//
//  HomeSectionController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/27.
//

import AVFoundation
import Foundation
import IGListKit
import AVKit
class HomeSectionController: ListBindingSectionController<Home>,
  ListBindingSectionControllerDataSource
{
  var player : AVPlayer?
  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
    guard let home = object as? Home else {
      fatalError()
    }
    let result: [ListDiffable] = [
      WordViewModel(word_id: home.word.word_id, word: home.word.word, word_image: home.word.word_image, word_audio: home.word.word_audio),
    ]
    return result + home.cards
  }

  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
    print("1")
    let identifier: String
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
      height = 150

    case is WordViewModel:
      height = 200
    default:
      height = 55
    }
    return CGSize(width: width, height: height)
  }
  override func didSelectItem(at index: Int) {
    guard let selectedCell = collectionContext?.cellForItem(at: index, sectionController: self) as? CardCell else { return }
    guard var place_id = selectedCell.place_id else { return }
    ApiHelper.placeDetailAllRead(place_id: place_id) { result in
      
      let status = Int(result!.result_code)
      switch status {
      case 200:
        print("\(place_id) and \(index)")
      default:
        print("hello")
      }
    }
    
  }
  override init() {
    super.init()
    dataSource = self
    inset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    minimumLineSpacing = 20
  }
}

extension HomeSectionController: WordCellDelegate {
  func didTap(cell: WordCell) {
    guard let url = URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3") else {
      fatalError()
    }
    let playerItem = AVPlayerItem(url: url)
    self.player = AVPlayer(playerItem: playerItem)
   
    player?.play()
    
  }
}
