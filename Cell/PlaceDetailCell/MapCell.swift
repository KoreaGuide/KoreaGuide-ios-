//
//  MapCell.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/04/05.
//

import Foundation
import IGListKit
import MapKit
final class MapCell: UICollectionViewCell, CLLocationManagerDelegate {
  @IBOutlet var address_Label: UILabel!
  @IBOutlet var myMap: MKMapView!

  var map_x: Float?
  var map_y: Float?
  let locationManager = CLLocationManager()
  var address: String?
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? MapViewModel else { return }
    map_x = viewModel.map_x
    map_y = viewModel.map_y
    address = viewModel.address
    address_Label.text = address
    address_Label.numberOfLines = 3
    address_Label.textAlignment = .center
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    myMap.showsUserLocation = true

    locationManager.startUpdatingLocation()
    setAnnotation(latitudeValue: CLLocationDegrees(map_y!), longitudeValue: CLLocationDegrees(map_x!), delta: 0.01, title: address!, subtitle: "")

    locationManager.stopUpdatingLocation()
  }

  // 위도와 경도, 스팬(영역 폭)을 입력받아 지도에 표시
  func goLocation(latitudeValue: CLLocationDegrees,
                  longtudeValue: CLLocationDegrees,
                  delta span: Double) -> CLLocationCoordinate2D
  {
    let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
    let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
    let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
    myMap.setRegion(pRegion, animated: true)
    return pLocation
  }

  // 특정 위도와 경도에 핀 설치하고 핀에 타이틀과 서브 타이틀의 문자열 표시
  func setAnnotation(latitudeValue: CLLocationDegrees,
                     longitudeValue: CLLocationDegrees,
                     delta span: Double,
                     title strTitle: String,
                     subtitle strSubTitle: String)
  {
    let annotation = MKPointAnnotation()
    annotation.coordinate = goLocation(latitudeValue: latitudeValue, longtudeValue: longitudeValue, delta: span)
    annotation.title = strTitle
    annotation.subtitle = strSubTitle
    myMap.addAnnotation(annotation)
  }

  // 위치 정보에서 국가, 지역, 도로를 추출하여 레이블에 표시
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let pLocation = locations.last
    _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!,
                   longtudeValue: (pLocation?.coordinate.longitude)!,
                   delta: 0.01)
    CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: { (placemarks, error) -> Void in
      let pm = placemarks!.first
      let country = pm!.country
      var address: String = ""
      if country != nil {
        address = country!
      }
      if pm!.locality != nil {
        address += " "
        address += pm!.locality!
      }
      if pm!.thoroughfare != nil {
        address += " "
        address += pm!.thoroughfare!
      }
    })
    locationManager.stopUpdatingLocation()
  }
}
