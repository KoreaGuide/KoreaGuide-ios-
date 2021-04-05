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
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet var LearnButton: UIButton!
  var res: PlaceDetailModel?
  var data = [ListDiffable]()
  var place_id : Int?
  lazy var adapter: ListAdapter = {
    ListAdapter(updater: ListAdapterUpdater(), viewController: self)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    ApiHelper.placeDetailAllRead(place_id: place_id!) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        self.res = result
        self.data.append(PlaceDetail(place_id: (self.res?.data.id)!, placeDetail: self.res!))
        self.adapter.performUpdates(animated: true, completion: nil)
      default:
        print("hello")
      }
    }
    adapter.collectionView = collectionView
    adapter.dataSource = self
    
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
