//
//  HomeSectionController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/27.
//

import AVFoundation
import AVKit
import Foundation
import IGListKit
import UIKit
class HomeSectionController: ListBindingSectionController<Home>,
  ListBindingSectionControllerDataSource
{
  var soundEffect: AVAudioPlayer?
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
      height = 300

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
    inset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    minimumLineSpacing = 20
  }

  override func didSelectItem(at index: Int) {
    guard let selectedCell = collectionContext?.cellForItem(at: index, sectionController: self) as? CardCell else { return }
    guard let place_id = selectedCell.place_id else { return }

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let postingVC = storyboard.instantiateViewController(withIdentifier: "placeDetailViewController") as! placeDetailViewController
    postingVC.place_id = place_id
    viewController?.navigationController?.pushViewController(postingVC, animated: true)
  }
}

extension HomeSectionController: WordCellDelegate {
  func didTap(cell: WordCell) {
    let url = Bundle.main.url(forResource: cell.word_id, withExtension: "mp3")
    if let url = url {
      do {
        soundEffect = try AVAudioPlayer(contentsOf: url)
        guard let sound = soundEffect else {
          return
        }
        sound.prepareToPlay()
        sound.play()
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}
