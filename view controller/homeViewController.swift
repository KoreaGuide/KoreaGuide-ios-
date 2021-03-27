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
  @IBOutlet var menuButton: UIButton!
  @IBOutlet var collectionView: UICollectionView!
  var layout = UICollectionViewFlowLayout()
  // var data: homeReadModel?
  var data = [ListDiffable]()
  lazy var adapter: ListAdapter = {
    ListAdapter(updater: ListAdapterUpdater(), viewController: self)
  }()

  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    return data
  }

  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    print("1")
    let sectionController = HomeSectionController()
    return sectionController
  }

  func emptyView(for listAdapter: ListAdapter) -> UIView? {
    return nil
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    /* ApiHelper.homeRead { result in
       self.data = result
       let status = Int(self.data!.status)
       switch status {
       case 409:
         self.defaultAlert(title: "알람", message: "이미 가입되어 있는 이메일입니다.", callback: nil)

       case 201:
         self.defaultAlert(title: "알람", message: "계정이 생성되었습니다.", callback: nil)
       default:
         self.defaultAlert(title: "알람", message: "서버 장애가 발생하였습니다. ", callback: nil)

         self.adapter.performUpdates(animated: true, completion: nil)
       }
     } */
    data.append(Home(cards: [CardViewModel(title_kor: "롯데월드", title_eng: "Lotte World", image: "http://tong.visitkorea.or.kr/cms/resource/77/2553577_image2_1.jpg"),
                             CardViewModel(title_kor: "한국민속촌", title_eng: "Korean Folk Village", image: "http://tong.visitkorea.or.kr/cms/resource/89/2612489_image2_1.jpg"),
                             CardViewModel(title_kor: "제부도", title_eng: "jebudo Island", image: "http://tong.visitkorea.or.kr/cms/resource/34/2482734_image2_1.jpg")], word: WordViewModel(word_id: 2, word: "cat", word_image: "http://tong.visitkorea.or.kr/cms/resource/23/2678623_image2_1.jpg", word_audio: "https://drive.google.com/file/d/1pHRW50oxel6UbOdlLNo6e-LUfpaAik43/view?usp=sharing")))
    adapter.collectionView = collectionView
    adapter.dataSource = self
  }
}
