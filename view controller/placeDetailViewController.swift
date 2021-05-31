//
//  placeDetailViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/29.
//

import Foundation
import IGListKit
import SwiftUI
import UIKit

class placeDetailViewController: UIViewController, ListAdapterDataSource {
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var LearnButton: UIButton!
  @IBOutlet var headerTitle: UILabel!
  @IBOutlet var leftButton: UIButton!
  @IBOutlet var BookMarkButton: UIButton!

  @IBSegueAction func ToAddWordView(_ coder: NSCoder) -> UIViewController? {
    return UIHostingController(coder: coder, rootView: WordAddView(viewModel: viewModel))
  }

  var res: PlaceDetailModel?
  var data = [ListDiffable]()
  var place_id: Int?
  var viewModel: WordAddViewModel {
    WordAddViewModel(place_id: self.place_id!)
  }

  lazy var adapter: ListAdapter = {
    ListAdapter(updater: ListAdapterUpdater(), viewController: self)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = true
    ApiHelper.placeDetailAllRead(place_id: place_id!) { result in
      let status = Int(result!.result_code)
      switch status {
      case 200:
        self.res = result
        self.data.append(PlaceDetail(place_id: (self.res?.data.id)!, placeDetail: self.res!))
        self.adapter.performUpdates(animated: true, completion: nil)
        self.place_id = result?.data.id
        self.headerTitle.text = result?.data.title
        if result?.data.place_status != .not {
          self.BookMarkButton.isSelected = true
        }
      default:
        print("hello")
      }

      self.LearnButton.layer.borderWidth = 2
      self.LearnButton.layer.borderColor = #colorLiteral(red: 0.4645748071, green: 0.5725829005, blue: 0.5960008502, alpha: 1)
      self.LearnButton.layer.cornerRadius = 22
      self.LearnButton.layer.backgroundColor = #colorLiteral(red: 0.3324496303, green: 0.3750489015, blue: 0.4744465351, alpha: 1)

      // self.viewModel = WordAddViewModel(place_id: self.place_id!)
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

  @IBAction func onTapBookMark(_ sender: UIButton) {
    if !BookMarkButton.isSelected {
      ApiHelper.myMapCreate(place_id: res?.data.id ?? 0, status: res?.data.place_status ?? .not, diary: nil) { response in
        let status = response?.result_code
        switch status {
        case 200:
          self.BookMarkButton.isSelected = true
          self.BookMarkButton.setNeedsDisplay()
          print(self.BookMarkButton.isSelected)
        default:
          print("어떻게 그런일이..")
        }
      }
    }
  }
  @IBAction func didTapLeftButton(_ sender: UIButton)
  {
    self.navigationController?.popViewController(animated: true)
  }
}
