//
//  mapViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/02/18.
//

import MapKit
import NMapsMap
import UIKit
class mapViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let mapView = NMFNaverMapView(frame: view.frame)
    view.addSubview(mapView)
    let southWest = NMGLatLng(lat: 32.849, lng: 125.422684)
    let northEast = NMGLatLng(lat: 38.611111111111114, lng: 131.87277777777777)
    let bounds = NMGLatLngBounds(southWest: southWest, northEast: northEast)
    mapView.mapView.extent = bounds
    let centerPosition = NMGLatLng(lat: 33.11194444444445, lng: 124.61)
    let cameraUpdate = NMFCameraUpdate(scrollTo: centerPosition)
    mapView.mapView.moveCamera(cameraUpdate)
    mapView.showZoomControls = true
  }
}

class Coordinator: NSObject, NMFMapViewTouchDelegate, NMFMapViewCameraDelegate, NMFMapViewOptionDelegate {


  func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
    // 마커 아닌 곳 탭하면 하단뷰 닫아준다.
  }
}

func makeCoordinator() -> Coordinator {
  return Coordinator()
}
