//
//  mapViewController.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/02/18.
//

import GeoJSON
import GoogleMaps
import GoogleMapsUtils
import MapKit
import SwiftUI
import UIKit
class mapViewController: UIViewController {
  @IBOutlet var mapView: MKMapView!
  let coordinator = MapCoordinator()
  override func viewDidLoad() {
    super.viewDidLoad()
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
          print("@@")
          let data = try JSONDecoder().decode(properties.self, from: feature.properties!)
        } catch {
          fatalError()
        }
        
        for geo in feature.geometry {
          if let polygon = geo as? MKPolygon {
            overlays.append(polygon) // overlay 타입으로 변환
          } else if let multiPolygon = geo as? MKMultiPolygon {
            overlays.append(multiPolygon)
          }
        }
      }
    }
    return overlays
  }

  func setMapView(frame: CGRect) -> GMSMapView {
    let mapView = GMSMapView(frame: view.frame)
    let southWest = CLLocationCoordinate2D(latitude: 32.849, longitude: 125.422684)
    let northEast = CLLocationCoordinate2D(latitude: 38.611111111111114, longitude: 131.87277777777777)
    let bounds = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
    let camera = GMSCameraPosition.camera(withLatitude: 35.87810, longitude: 127.85454, zoom: 7)
    mapView.camera = camera
    mapView.setMinZoom(7, maxZoom: 20)
    mapView.cameraTargetBounds = bounds
    mapView.mapType = .none
    return mapView
  }

  final class MapCoordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if let polygon = overlay as? MKPolygon {
        let renderer = MKPolygonRenderer(polygon: polygon)
        renderer.fillColor = UIColor.red
        renderer.strokeColor = UIColor.black
        return renderer
      } else if let polygon = overlay as? MKMultiPolygon {
        let renderer = MKMultiPolygonRenderer(multiPolygon: polygon)
        renderer.fillColor = UIColor.red
        renderer.strokeColor = UIColor.black
        return renderer
      }
      return MKOverlayRenderer(overlay: overlay)
    }
  }
}
