//
//  placeDetailViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/29.
//

import Foundation
import IGListKit
import UIKit
class placeDetailViewController: UIViewController, ListAdapterDataSource {
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var LearnButton: UIButton!
  var layout = UICollectionViewFlowLayout()
  var res: PlaceDetailModel?
  var data = [ListDiffable]()
  lazy var adapter: ListAdapter = {
    ListAdapter(updater: ListAdapterUpdater(), viewController: self)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    adapter.collectionView = collectionView
    adapter.dataSource = self
    adapter.performUpdates(animated: true, completion: nil)
    data.append(PlaceDetail(place_id: (res?.data.id)!, placeDetail: res!))
  }
  
  

  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    return data
  }

  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    let sectionController = PlaceDetailSectionController()
    return sectionController
  }

  func emptyView(for listAdapter: ListAdapter) -> UIView? {
    return nil
  }
}
