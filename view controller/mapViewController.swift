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
    let map = setMapView(frame: view.frame)
    view.addSubview(map)
    
  }
    func setMapView(frame : CGRect) -> NMFNaverMapView {
        let mapView = NMFNaverMapView(frame: view.frame)
        view.addSubview(mapView)
        let southWest = NMGLatLng(lat: 32.849, lng: 125.422684)
        let northEast = NMGLatLng(lat: 38.611111111111114, lng: 131.87277777777777)
        let bounds = NMGLatLngBounds(southWest: southWest, northEast: northEast)
        mapView.mapView.extent = bounds
        let centerPosition = NMGLatLng(lat: 35.87810, lng: 127.85454)
        let cameraUpdate = NMFCameraUpdate(scrollTo: centerPosition)
        mapView.mapView.moveCamera(cameraUpdate)
        mapView.showZoomControls = true
        
        mapView.mapView.minZoomLevel = 6
        mapView.mapView.maxZoomLevel = 15
        mapView.mapView.zoomLevel = 6
        return mapView
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
