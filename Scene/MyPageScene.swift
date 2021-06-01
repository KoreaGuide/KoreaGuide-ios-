//
//  MyPageScene.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/05/31.
//

import Combine
import Foundation
import MapKit
import SwiftUI
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
        SlidingTabView(selection: $viewModel.tabNumber, tabs: ["My Place", "My Map", "My Word"])
        if viewModel.tabNumber == 0 {
          MyPageKeepedPostView(viewModel: viewModel)
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
    .onAppear {
      ApiHelper.myWishRead { result in
        let status = result!.result_code
        switch status {
        case 200:
          viewModel.placeInfo = (result?.data.place_list)!
        default:
          break
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
  @Published var selectedPlace : PlaceModel?
  @Published var cancellable = Set<AnyCancellable>()
  @Published var placeInfo: [PlaceModel] = []
  init() {
    ApiHelper.myWishRead { result in
      let status = result!.result_code
      switch status {
      case 200:
        self.placeInfo = (result?.data.place_list)!
      default:
        break
      }
    }
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

struct MyPageKeepedPostView: View {
  @ObservedObject var viewModel: MyPageSceneViewModel
  var body: some View {
    if viewModel.placeInfo.count == 0 {
      VStack {
        Spacer()
        Image("lightgrayCalendar")
          .resizable()
          .frame(width: 58, height: 55)
          .padding(.vertical, 20)
        Text("There is no stored place. \n Please add a place.")
          .foregroundColor(Color("silver"))
          .multilineTextAlignment(.center)
        Spacer()
      }
    } else {
      GridView(rows: (viewModel.placeInfo.count + 1 )/2,
               columns: 2) { row, col in
        let a = row * 2 + col
        if (viewModel.placeInfo.count > a) && (a >= 0) {
          PostGridSquareViewForKeeped(viewModel: viewModel, index: a)
            .onTapGesture {
              viewModel.selectedPlace = viewModel.placeInfo[a]
            }
        }
      }
    }
  }
}

class KeepedPostViewModel: ObservableObject {}

struct MapView: UIViewRepresentable {
  @ObservedObject var viewModel: MyPageSceneViewModel
  func makeUIView(context: Context) -> MyMapView {
    let view = MyMapView()
    view.delegate = context.coordinator
    view.addOverlays(context.coordinator.parseGeoJson())
    viewModel.$placeInfo
      .receive(on: DispatchQueue.main)
      .sink { _ in
    view.addAnnotations(context.coordinator.makePins())
      }
      .store(in: &viewModel.cancellable)
    view.isUserInteractionEnabled = true
    return view
  }

  class Coordinator: NSObject, MKMapViewDelegate, UIColorPickerViewControllerDelegate {
    init(viewModel: MyPageSceneViewModel) {
      self.viewModel = viewModel
    }

    @ObservedObject var viewModel: MyPageSceneViewModel
    func makePins() -> [MKPointAnnotation] {
      var pins = [MKPointAnnotation]()

      viewModel.placeInfo.forEach {
        let pin = MKPointAnnotation()
        pin.title = $0.title
        if $0.map_y != "null" {
          pin.coordinate = CLLocationCoordinate2D(latitude: Double($0.map_y!)!, longitude: Double($0.map_x!)!)
          pin.subtitle = String($0.my_map_id)
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
    return Coordinator(viewModel: viewModel)
  }
}
