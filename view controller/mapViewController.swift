//
//  mapViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/02/18.
//

import MapKit
import SwiftUI
import UIKit
class mapViewController: UIViewController, MapViewTouchDelegate, MKMapViewDelegate {
  @IBOutlet var mapView: MyMapView!
  let coordinator = MapCoordinator()
  var target: MKOverlay?
  var placesInfo: [place] = []
  var regionList: [Region] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView = MyMapView(frame: view.frame)
    view.addSubview(mapView)
    mapView.mapViewTouchDelegate = self
    mapView.delegate = self
    mapView.addOverlays(parseGeoJson())
    mapView.addAnnotations(makePins())
    
  }

  func makePins() -> [MKPointAnnotation] {
    var pins = [MKPointAnnotation]()
    UserDefaults.placeInfo.forEach {
      let pin = MKPointAnnotation()
      pin.title = $0.title
      if $0.map_y != "null" {
        pin.coordinate = CLLocationCoordinate2D(latitude: Double($0.map_y)!, longitude: Double($0.map_x)!)
        pin.subtitle = String($0.id)
        pins.append(pin)
        
      }
    }

    return pins
  }
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

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard annotation is MKPointAnnotation else { return nil }

    let identifier = annotation.title!
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier!)
    if annotationView == nil {
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      annotationView!.canShowCallout = true
      let pinImage = UIImage(named: "marker")
      annotationView!.image = pinImage
    } else {
      annotationView!.annotation = annotation
    }

    return annotationView
  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let postingVC = storyboard.instantiateViewController(withIdentifier: "placeDetailViewController") as! placeDetailViewController
    postingVC.place_id = Int((view.annotation?.subtitle)!!)
    navigationController?.pushViewController(postingVC, animated: true)
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
      let cancle = UIAlertAction(title: "Cancle", style: .cancel)
      action.addAction(search)
      action.addAction(edit)
      action.addAction(cancle)
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
      let cancle = UIAlertAction(title: "Cancle", style: .cancel)
      action.addAction(search)
      action.addAction(edit)
      action.addAction(cancle)
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
