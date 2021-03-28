//
//  homeViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/03.
//

import Foundation
import IGListKit
import UIKit
class homeViewController: UIViewController, ListAdapterDataSource {
  @IBOutlet var collectionView: UICollectionView!
  var layout = UICollectionViewFlowLayout()
  var res: homeReadModel?
  var data = [ListDiffable]()
  lazy var adapter: ListAdapter = {
    ListAdapter(updater: ListAdapterUpdater(), viewController: self)
  }()

  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    return data
  }

  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    let sectionController = HomeSectionController()
    return sectionController
  }

  func emptyView(for listAdapter: ListAdapter) -> UIView? {
    return nil
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    ApiHelper.homeRead { result in
      self.res = result
      let status = Int(self.res!.result_code)
      
      switch status {
      case 200:
        self.data.append(Home(cards: [CardViewModel(card: self.res!.data.place_list[0]), CardViewModel(card: self.res!.data.place_list[1]), CardViewModel(card: self.res!.data.place_list[2])], word: WordViewModel(key: self.res!.data)))
        self.adapter.performUpdates(animated: true, completion: nil)
      default:
        self.defaultAlert(title: "알람", message: "서버 장애가 발생하였습니다. ", callback: nil)
      }
    }
    adapter.collectionView = collectionView
    adapter.dataSource = self
  }
}
