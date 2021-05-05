//
//  mapViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/02/18.
//

import MapKit
import SwiftUI
import UIKit
class mapViewController: UIViewController, MapViewTouchDelegate, MKMapViewDelegate{
  @IBOutlet var mapView: MyMapView!
  let coordinator = MapCoordinator()
  var target: MKOverlay?
  var placesInfo: [place] = []
  var regionList: [Region] = []
  override func viewDidLoad() {
    super.viewDidLoad()

    mapView.mapViewTouchDelegate = self
    mapView.delegate = coordinator
    mapView.addOverlays(parseGeoJson())

    ApiHelper.regionListRead {
      result in
      print(result!)
      let status = result?.result_code
      switch status {
      case 200:
        self.regionList = (result?.data.region_list)!
      default:
        fatalError()
      }
    }
    regionList.forEach {
      ApiHelper.placeListForRegionRead(region_id: $0.areacode) { result in
        print(result!)
        let status = result?.result_code
        switch status {
        case 200:
          self.placesInfo.append(contentsOf: result!.data.place_list) 
        case 204:
          print("NO_CONTENT")
        case 500:
          print("region id 오류")
        default:
          print("알 수 없는 에러 발생")
        }
      }
    }
  }
  func makePinAnnotation(place : place) {
    let pin = MKPointAnnotation()
    pin.title = place.title
    pin.coordinate = CLLocationCoordinate2D(latitude: Double(place.map_x)!, longitude: Double(place.map_y)!)
    mapView.addAnnotation(pin)
  }
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      guard annotation is MKPointAnnotation else { return nil }

      let identifier = "Annotation"
      var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

      if annotationView == nil {
          annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
          annotationView!.canShowCallout = true
      } else {
          annotationView!.annotation = annotation
      }

      return annotationView
  }
  func parseGeoJson() -> [MKOverlay] {
    guard let path = Bundle.main.path(forResource: "map", ofType: "geojson") else {
      fatalError()
    }
    let url = URL(fileURLWithPath: path)
    var geoJson = [MKGeoJSONObject]()
    do {
      let data = try Data(contentsOf: url)
      geoJson = try MKGeoJSONDecoder().decode(data)
    } catch {
      fatalError()
    }
    var overlays = [MKOverlay]()
    for item in geoJson {
      if let feature = item as? MKGeoJSONFeature {
        do {
          let data = try JSONDecoder().decode(properties.self, from: feature.properties!)
          for geo in feature.geometry {
            if let polygon = geo as? MKPolygon {
              polygon.title = data.color
              polygon.subtitle = data.sgg_nm
              overlays.append(polygon) // overlay 타입으로 변환
            } else if let multiPolygon = geo as? MKMultiPolygon {
              multiPolygon.title = data.color

              multiPolygon.subtitle = data.sgg_nm

              overlays.append(multiPolygon)
            }
          }
        } catch {
          fatalError()
        }
      }
    }
    return overlays
  }

  func setMapView() {
    mapView.isZoomEnabled = false
    mapView.mapType = .mutedStandard
  }

  final class MapCoordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if let polygon = overlay as? MKPolygon {
        print(polygon.title!)
        let renderer = MKPolygonRenderer(polygon: polygon)
        renderer.fillColor = UIColor(hex: polygon.title!)
        renderer.strokeColor = UIColor.black
        return renderer
      } else if let polygon = overlay as? MKMultiPolygon {
        let renderer = MKMultiPolygonRenderer(multiPolygon: polygon)
        renderer.fillColor = UIColor(hex: polygon.title!)
        renderer.strokeColor = UIColor.black
        return renderer
      }
      return MKOverlayRenderer(overlay: overlay)
    }
  }

  func polygonsTapped(polygons: [MKPolygon]) {
    polygons.forEach { polygon in
      let action = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
      let edit = UIAlertAction(title: "Edit map color", style: .default) { action in
        let picker = UIColorPickerViewController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        self.target = polygon
      }
      let search = UIAlertAction(title: "Search", style: .default) { action in
        // 시점이동하고 줌 시키기.
      }
      action.addAction(search)
      action.addAction(edit)
      self.present(action, animated: true, completion: nil)
    }
  }

  func multiPolygonsTapped(multiPolygons: [MKMultiPolygon]) {
    multiPolygons.forEach { polygon in
      let action = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
      let edit = UIAlertAction(title: "Edit map color", style: .default) { action in
        let picker = UIColorPickerViewController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        self.target = polygon
      }
      let search = UIAlertAction(title: "Search", style: .default) { action in
        // 시점이동하고 줌 시키기.
      }
      action.addAction(search)
      action.addAction(edit)
      self.present(action, animated: true, completion: nil)
    }
  }
}

extension mapViewController: UIColorPickerViewControllerDelegate {
  func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    if let target = target as? MKPolygon {
      target.title = viewController.selectedColor.toHexString(alpha: true)
      mapView.addOverlay(target)
      mapView.setNeedsDisplay()
    }
    if let target = target as? MKMultiPolygon {
      target.title = viewController.selectedColor.toHexString(alpha: true)
      mapView.addOverlay(target)
      mapView.setNeedsDisplay()
    }
  }
}
