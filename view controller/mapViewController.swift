//
//  mapViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/02/18.
//

import MapKit
import SwiftUI
import UIKit
class mapViewController: UIViewController, MapViewTouchDelegate {
  @IBOutlet var mapView: MyMapView!
  let coordinator = MapCoordinator()
  var target: MKOverlay?
  override func viewDidLoad() {
    super.viewDidLoad()

    mapView.mapViewTouchDelegate = self
    mapView.delegate = coordinator
    mapView.addOverlays(parseGeoJson())
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
    mapView.isScrollEnabled = false
    mapView.isRotateEnabled = false
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
    polygons.forEach {
      let picker = UIColorPickerViewController()
      picker.delegate = self
      self.present(picker, animated: true, completion: nil)
      target = $0
    }
  }

  func multiPolygonsTapped(multiPolygons: [MKMultiPolygon]) {
    multiPolygons.forEach {
      let picker = UIColorPickerViewController()
      picker.delegate = self
      self.present(picker, animated: true, completion: nil)
      target = $0
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
