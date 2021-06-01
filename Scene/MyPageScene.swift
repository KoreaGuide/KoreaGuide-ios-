//
//  MyPageScene.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/05/31.
//

import Foundation
import SwiftUI
import MapKit
struct MyPageScene: View {
  @ObservedObject var viewModel = MyPageSceneViewModel()
  @State var selectionLimit = 0
  var body: some View {
    ZStack {
      VStack {
        HStack {
          HStack {
            // 사진
            if !UserDefaults.profile.isEmpty {
              Image(uiImage: UIImage(data: UserDefaults.profile)!)
                .resizable()
                .frame(width: 51, height: 51, alignment: .center)
                .clipShape(Circle())
            } else if viewModel.image != nil {
              Image(uiImage: viewModel.image!)
                .resizable()
                .frame(width: 51, height: 51, alignment: .center)
                .clipShape(Circle())
            } else {
              Image("personNoImg")
                .resizable()
                .frame(width: 51, height: 51, alignment: .center)
                .clipShape(Circle())
            }

            // 이름, 연동 방법
            VStack(alignment: .leading) {
              HStack {
                Text(UserDefaults.nickname)
                  .foregroundColor(.white)
                Image("silverArrow")
              }
            }
          }.onTapGesture {
            // 네비게이션 링크 실행하기
            viewModel.showImagePicker.toggle()
          }
          Spacer()
        }
        .padding(.horizontal, 18)
        SlidingTabView(selection: $viewModel.tabNumber, tabs: ["보관함", "내 지도", "내 퀴즈"])
        if viewModel.tabNumber == 0 {
          EmptyView()
          Spacer()
        } else if viewModel.tabNumber == 1 {
          MapView(viewModel: viewModel)
          Spacer()
        } else if viewModel.tabNumber == 2 {
          EmptyView()
          Spacer()
        } else {
          EmptyView()
          Spacer()
        }
      }
      
      .sheet(isPresented: $viewModel.showImagePicker) {
        PhotoPicker(isPresented: $viewModel.showImagePicker, selectionLimit: $selectionLimit) { image in

          viewModel.image = image
          UserDefaults.profile = image.pngData() ?? Data()
        }
      }
    }
    .background(Image("background")
      .resizable()
      .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
      .ignoresSafeArea())
    .navigationBarTitle("")
    .navigationBarHidden(true)
  }
}

class MyPageSceneViewModel: ObservableObject {
  @Published var showImagePicker: Bool = false
  @Published var image: UIImage?
  @Published var tabNumber: Int = 0
  @Published var keepedPostViewModel = KeepedPostViewModel()
  @Published var placeInfo : [place] = []
  init () {
    
  }
}

struct ProfileImage: UIViewRepresentable {
  @ObservedObject var viewModel: MyPageSceneViewModel

  func makeUIView(context: Context) -> UIImageView {
    let view = UIImageView()
    view.image = viewModel.image

    return view
  }

  func updateUIView(_: UIImageView, context _: Context) {}
}

struct MyPageKeepedPostView : View {
  @ObservedObject var viewModel : KeepedPostViewModel
  var body: some View {
    ZStack{
      
    }
  }
}

class KeepedPostViewModel : ObservableObject {
  
}

struct MapView : UIViewRepresentable {
  @ObservedObject var viewModel : MyPageSceneViewModel
  func makeUIView(context: Context) ->MyMapView {
    let view = MyMapView()
    view.delegate = context.coordinator
    view.addOverlays(context.coordinator.parseGeoJson())
    view.addAnnotations(context.coordinator.makePins())
    view.isUserInteractionEnabled = true
    return view
  }
  
  class Coordinator: NSObject, MKMapViewDelegate, UIColorPickerViewControllerDelegate {
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

//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//      let storyboard = UIStoryboard(name: "Main", bundle: nil)
//      let postingVC = storyboard.instantiateViewController(withIdentifier: "placeDetailViewController") as! placeDetailViewController
//      postingVC.place_id = Int((view.annotation?.subtitle)!!)
//      self.postingVC = postingVC
//
//    }

    func parseGeoJson() -> [MKOverlay] {
      guard let path = Bundle.main.path(forResource: "mapJson", ofType: "geojson") else {
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
                polygon.title = getColor(code: data.sgg_cd)
                polygon.subtitle = data.sgg_cd
                overlays.append(polygon) // overlay 타입으로 변환
              } else if let multiPolygon = geo as? MKMultiPolygon {
                multiPolygon.title = getColor(code: data.sgg_cd)
                multiPolygon.subtitle = data.sgg_cd
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
    
  }

  func updateUIView(_: MyMapView, context _: Context) {}
  
  func makeCoordinator() -> Coordinator {
    return Coordinator()
  }
  
}
