//
//  homeViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/03.
//

import Foundation
import IGListKit
import UIKit
import SwiftUI

class homeViewController: UIViewController, ListAdapterDataSource {
  @IBOutlet var collectionView: UICollectionView!
  var layout = UICollectionViewFlowLayout()
  
  @IBSegueAction func ToTodayWordView(_ coder: NSCoder) -> UIViewController? {
    return UIHostingController(coder: coder, rootView: TodayWordView(viewModel: TodayWordViewModel()))
  }
  
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
        self.data.append(Home(cards: [CardViewModel(card: self.res!.data.place_list[0]), CardViewModel(card: self.res!.data.place_list[1]), CardViewModel(card: self.res!.data.place_list[2])], word: WordViewModel(word_id: self.res!.data.word_id, word: self.res!.data.word, word_image: self.res!.data.word_image, word_audio: self.res!.data.word_audio)))

        self.adapter.performUpdates(animated: true, completion: nil)
      default:
        self.defaultAlert(title: "알람", message: "서버 장애가 발생하였습니다. ", callback: nil)
      }
    }
    adapter.collectionView = collectionView
    adapter.dataSource = self
    ApiHelper.regionListRead {
      result in
      print(result!)
      let status = result?.result_code
      switch status {
      case 200:
        result?.data.region_list.forEach {
          ApiHelper.placeListForRegionRead(region_id: $0.areacode) { result1 in
            print(result1!)
            let status = result1?.result_code
            switch status {
            case 200:
              UserDefaults.placeInfo.append(contentsOf: result1!.data.place_list)
              print(UserDefaults.placeInfo.count)
            case 204:
              print("NO_CONTENT")
            case 500:
              print("region id 오류")
            default:
              print("알 수 없는 에러 발생")
            }
          }
        }
      default:
        fatalError()
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true
  }
}
