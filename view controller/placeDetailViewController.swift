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
  var res: PlaceDetailModel?
  var data = [ListDiffable]()
  var place_id: Int?
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
      self.LearnButton.layer.borderWidth = 2
      self.LearnButton.layer.borderColor = #colorLiteral(red: 0.4645748071, green: 0.5725829005, blue: 0.5960008502, alpha: 1)
      self.LearnButton.layer.cornerRadius = 22
      self.LearnButton.layer.backgroundColor = #colorLiteral(red: 0.3324496303, green: 0.3750489015, blue: 0.4744465351, alpha: 1)
    }
    adapter.collectionView = collectionView
    adapter.dataSource = self
    guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { fatalError() }
    layout.sectionHeadersPinToVisibleBounds = true
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
    let backButton = UIBarButtonItem()
    backButton.title = ""
    self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    self.navigationController?.navigationBar.topItem?.title = res?.data.title
  }
}
