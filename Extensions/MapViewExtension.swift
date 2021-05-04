//
//  MapViewExtension.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/05/03.
//

import Foundation
import MapKit
import UIKit
protocol MapViewTouchDelegate: AnyObject {
  func polygonsTapped(polygons: [MKPolygon])
  func multiPolygonsTapped(multiPolygons: [MKMultiPolygon])
}

extension MKPolygon {
  func contain(coor: CLLocationCoordinate2D) -> Bool {
    let polygonRenderer = MKPolygonRenderer(polygon: self)
    let currentMapPoint = MKMapPoint(coor)
    let polygonViewPoint: CGPoint = polygonRenderer.point(for: currentMapPoint)
    if polygonRenderer.path == nil {
      return false
    } else {
      return polygonRenderer.path.contains(polygonViewPoint)
    }
  }
}

extension MKMultiPolygon {
  func contain(coor: CLLocationCoordinate2D) -> Bool {
    let polygonRenderer = MKMultiPolygonRenderer(multiPolygon: self)
    let currentMapPoint = MKMapPoint(coor)
    let polygonViewPoint: CGPoint = polygonRenderer.point(for: currentMapPoint)
    if polygonRenderer.path == nil {
      return false
    } else {
      return polygonRenderer.path.contains(polygonViewPoint)
    }
  }
}

class MyMapView: MKMapView {
  weak var mapViewTouchDelegate: MapViewTouchDelegate?
  override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      if touch.tapCount == 1 {
        let touchLocation = touch.location(in: self)
        let locationCoordinate = convert(touchLocation, toCoordinateFrom: self)
        var polygons: [MKPolygon] = []
        var multiPolygons: [MKMultiPolygon] = []
        overlays.forEach {
          if let polygon = $0 as? MKPolygon {
            if polygon.contain(coor: locationCoordinate) {
              polygons.append(polygon)
            }
          }
          if let polygon = $0 as? MKMultiPolygon {
            if polygon.contain(coor: locationCoordinate) {
              multiPolygons.append(polygon)
            }
          }
        }
        if multiPolygons.count > 0 {
          mapViewTouchDelegate?.multiPolygonsTapped(multiPolygons: multiPolygons)
        }
        if polygons.count > 0 {
          // Do stuff here like use a delegate:
          mapViewTouchDelegate?.polygonsTapped(polygons: polygons)
        }
      }
    }
    super.touchesEnded(touches, with: event)
  }
}
