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
        NavigationLink(destination: NavigationLazyView(
          PlaceDetailView(viewModel: viewModel)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        ), isActive: $viewModel.didTapPlace) {
          EmptyView()
        }.isDetailLink(false)
        
        HStack {
          HStack {
            // 사진
            if !UserDefaults.profile.isEmpty {
              Image(uiImage: UIImage(data: UserDefaults.profile)!)
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
                .clipShape(Circle())
            } else if viewModel.image != nil {
              Image(uiImage: viewModel.image!)
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
                .clipShape(Circle())
            } else {
              Image("personNoImg")
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
                .clipShape(Circle())
            }

            VStack(alignment: .leading) {
              HStack {
                Text(UserDefaults.nickname)
                  .foregroundColor(.white)
                  .font(.system(size: 18, weight: .semibold))

                Image("silverArrow")
              }
            }
            .padding(.leading, 6)
          }.onTapGesture {
            // 네비게이션 링크 실행하기
            viewModel.showImagePicker.toggle()
          }
          Spacer()
        }
        .padding(.horizontal, 20)

        SlidingTabView(selection: $viewModel.tabNumber, tabs: ["My Place", "My Map", "My Word"])
        if viewModel.tabNumber == 0 {
          MyPageKeepedPostView(viewModel: viewModel)
          Spacer()
        } else if viewModel.tabNumber == 1 {
          MapView(viewModel: viewModel)

          Spacer()
        } else if viewModel.tabNumber == 2 {
          ProfileWordView(viewModel: viewModel)
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
  @Published var selectedPlace : PlaceModel?
  @Published var keepedPostViewModel = KeepedPostViewModel()
  
  @Published var cancellable = Set<AnyCancellable>()
  @Published var placeInfo: [PlaceModel] = []
  @Published var didTapPlace : Bool = false

  @Published var attendance: Int = 0
  @Published var week_quiz_result: [OneDayInfo] = []

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

    ProfileApiCaller.attendanceInfo { result in
      let status = Int(result?.result_code ?? 0)
      switch status {
      case 200:
        self.attendance = result?.data.attendance ?? 0
        self.week_quiz_result = result?.data.week_quiz_result ?? []
        print("----- attendance info get api done")
      default:
        print("----- attendance info get api error")
      }
    }
  }
  
  func reload() {
    ProfileApiCaller.attendanceInfo { result in
      let status = Int(result?.result_code ?? 0)
      switch status {
      case 200:
        self.attendance = result?.data.attendance ?? 0
        self.week_quiz_result = result?.data.week_quiz_result ?? []
        print("----- attendance info get api done")
      default:
        print("----- attendance info get api error")
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
struct MyPageWordView: View {
  @ObservedObject var viewModel : MyPageSceneViewModel
  var body: some View {
    VStack {
      Text("Great Job!\n Your attendance this week is: \(UserDefaults.week_attendance ?? 0)/7")
        .foregroundColor(.white)
        .font(.system(size: 20))
        .frame(alignment: .leading)
        .padding(.top, 40)
    }
  }
}

struct MyPageKeepedPostView: View {
  @ObservedObject var viewModel: MyPageSceneViewModel
  var body: some View {
    if viewModel.placeInfo.count == 0 {
      VStack {
        Spacer()
        Image("lightgrayCalendar")
          .resizable()
          .frame(width: 40, height: 40)
          .padding(.vertical, 20)
        Text("There is no stored place. \n Please add a place.")
          .foregroundColor(Color("silver"))
          .multilineTextAlignment(.center)
        Spacer()
      }
    } else {
      GridView(rows: (viewModel.placeInfo.count + 1) / 2,
               columns: 2) { row, col in
        let a = row * 2 + col
        if (viewModel.placeInfo.count > a) && (a >= 0) {
          PostGridSquareViewForKeeped(viewModel: viewModel, index: a)
            .onTapGesture {
              viewModel.selectedPlace = viewModel.placeInfo[a]
                viewModel.didTapPlace = true
            }
        }
      }
    }
  }
}

struct ProfileWordView: View {
  
  @ObservedObject var viewModel: MyPageSceneViewModel

  let height: CGFloat = 380
  
  let graphWidth: CGFloat = 12
  let graphPadding: CGFloat = 13
  
  let graphHeight: CGFloat = 100

  var body: some View {
    VStack {
      VStack {
        ZStack {
          RoundedRectangle(cornerRadius: 20)
            .frame(width: UIScreen.main.bounds.width - 40, height: 100)
            .foregroundColor(Color.white.opacity(1))

          HStack {
            VStack(alignment: .leading) {
              Text("Keep going!")
                .font(.system(size: 16, weight: .semibold))
              Text("Your attendance this week ")
                .font(.system(size: 16, weight: .semibold))
            }
            Spacer()
          }
          .padding(.horizontal, 20)

          HStack(alignment: .center) {
            Spacer()
            Text("\(viewModel.attendance)")
              .foregroundColor(Color("Mint"))
              .font(.system(size: 30, weight: .heavy))
            Text("/")
              .font(.system(size: 40, weight: .regular))
            Text("7")
              .font(.system(size: 30, weight: .heavy))
          }
          .padding(.horizontal, 20)
        }
      }
      .frame(width: UIScreen.main.bounds.width - 40, height: 100)
      .padding(.bottom, 20)

      VStack {
        ZStack {
          RoundedRectangle(cornerRadius: 20)
            .frame(width: UIScreen.main.bounds.width - 40, height: self.height)
            .foregroundColor(Color.white.opacity(1))

          VStack {
            // VStack {
            HStack {
              Text("Check your progress")
                .font(.system(size: 16, weight: .bold))
              Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
//              Rectangle()
//                .foregroundColor(Color.gray)
//                .frame(height: 2)
            // }

            HStack(alignment: .center) {
              Text("correct")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color("Mint"))
            }
            
            HStack(alignment: .bottom) {
              RoundedRectangle(cornerRadius: 10)
                .frame(width: graphWidth, height: viewModel.week_quiz_result[0].total == 0 ? 0.0 : CGFloat(viewModel.week_quiz_result[0].correct / viewModel.week_quiz_result[0].total) * graphHeight)
                .foregroundColor(Color("Mint"))
                .padding(.horizontal, graphPadding)

              RoundedRectangle(cornerRadius: 10)
                .frame(width: graphWidth, height: viewModel.week_quiz_result[1].total == 0 ? 0.0 : CGFloat(viewModel.week_quiz_result[1].correct / viewModel.week_quiz_result[1].total) * graphHeight)
                .foregroundColor(Color("Mint"))
                .padding(.horizontal, graphPadding)

              RoundedRectangle(cornerRadius: 10)
                .frame(width: graphWidth, height: viewModel.week_quiz_result[2].total == 0 ? 0.0 : CGFloat(viewModel.week_quiz_result[2].correct / viewModel.week_quiz_result[2].total) * graphHeight)
                .foregroundColor(Color("Mint"))
                .padding(.horizontal, graphPadding)

              RoundedRectangle(cornerRadius: 10)
                .frame(width: graphWidth, height: viewModel.week_quiz_result[3].total == 0 ? 0.0 : CGFloat(viewModel.week_quiz_result[3].correct / viewModel.week_quiz_result[3].total) * graphHeight)
                .foregroundColor(Color("Mint"))
                .padding(.horizontal, graphPadding)

              RoundedRectangle(cornerRadius: 10)
                .frame(width: graphWidth, height: viewModel.week_quiz_result[4].total == 0 ? 0.0 : CGFloat(viewModel.week_quiz_result[4].correct / viewModel.week_quiz_result[4].total) * graphHeight)
                .foregroundColor(Color("Mint"))
                .padding(.horizontal, graphPadding)

              RoundedRectangle(cornerRadius: 10)
                .frame(width: graphWidth, height: viewModel.week_quiz_result[5].total == 0 ? 0.0 : CGFloat(viewModel.week_quiz_result[5].correct / viewModel.week_quiz_result[5].total) * graphHeight)
                .foregroundColor(Color("Mint"))
                .padding(.horizontal, graphPadding)

              RoundedRectangle(cornerRadius: 10)
                .frame(width: graphWidth, height: viewModel.week_quiz_result[6].total == 0 ? 0.0 : CGFloat(viewModel.week_quiz_result[6].correct / viewModel.week_quiz_result[6].total) * graphHeight)
                .foregroundColor(Color("Mint"))
                .padding(.horizontal, graphPadding)
            }
            .frame(height: self.graphHeight)

            HStack {
              ZStack {
                Text(viewModel.week_quiz_result[0].day_of_week.first?.description ?? "")
                  .font(.system(size: 15, weight: .bold))
                Circle()
                  .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color("RingColor_DeepBlue"), Color("RingColor_LightBlue")]), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 1.6)
                  .frame(width: 30, height: 30)
                  .padding(4)
              }

              ZStack {
                Text(viewModel.week_quiz_result[1].day_of_week.first?.description ?? "")
                  .font(.system(size: 15, weight: .bold))
                Circle()
                  .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color("RingColor_DeepBlue"), Color("RingColor_LightBlue")]), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 1.6)
                  .frame(width: 30, height: 30)
                  .padding(4)
              }

              ZStack {
                Text(viewModel.week_quiz_result[2].day_of_week.first?.description ?? "")
                  .font(.system(size: 15, weight: .bold))
                Circle()
                  .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color("RingColor_DeepBlue"), Color("RingColor_LightBlue")]), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 1.6)
                  .frame(width: 30, height: 30)
                  .padding(4)
              }

              ZStack {
                Text(viewModel.week_quiz_result[3].day_of_week.first?.description ?? "")
                  .font(.system(size: 15, weight: .bold))
                Circle()
                  .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color("RingColor_DeepBlue"), Color("RingColor_LightBlue")]), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 1.6)
                  .frame(width: 30, height: 30)
                  .padding(4)
              }

              ZStack {
                Text(viewModel.week_quiz_result[4].day_of_week.first?.description ?? "")
                  .font(.system(size: 15, weight: .bold))
                Circle()
                  .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color("RingColor_DeepBlue"), Color("RingColor_LightBlue")]), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 1.6)
                  .frame(width: 30, height: 30)
                  .padding(4)
              }

              ZStack {
                Text(viewModel.week_quiz_result[5].day_of_week.first?.description ?? "")
                  .font(.system(size: 15, weight: .bold))
                Circle()
                  .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color("RingColor_DeepBlue"), Color("RingColor_LightBlue")]), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 1.6)
                  .frame(width: 30, height: 30)
                  .padding(4)
              }

              ZStack {
                Text(viewModel.week_quiz_result[6].day_of_week.first?.description ?? "")
                  .font(.system(size: 15, weight: .bold))
                Circle()
                  .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color("RingColor_DeepPink"), Color("RingColor_LightOrange")]), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 1.4)
                  .frame(width: 30, height: 30)
                  .padding(4)
              }
            }

            HStack(alignment: .top) {
              RoundedRectangle(cornerRadius: 10)
                .frame(width: graphWidth, height: viewModel.week_quiz_result[0].total == 0 ? 0.0 : CGFloat(viewModel.week_quiz_result[0].wrong / viewModel.week_quiz_result[0].total) * graphHeight)
                .foregroundColor(Color("Orange"))
                .padding(.horizontal, graphPadding)

              RoundedRectangle(cornerRadius: 10)
                .frame(width: graphWidth, height: viewModel.week_quiz_result[1].total == 0 ? 0.0 : CGFloat(viewModel.week_quiz_result[1].wrong / viewModel.week_quiz_result[1].total) * graphHeight)
                .foregroundColor(Color("Orange"))
                .padding(.horizontal, graphPadding)

              RoundedRectangle(cornerRadius: 10)
                .frame(width: graphWidth, height: viewModel.week_quiz_result[2].total == 0 ? 0.0 : CGFloat(viewModel.week_quiz_result[2].wrong / viewModel.week_quiz_result[2].total) * graphHeight)
                .foregroundColor(Color("Orange"))
                .padding(.horizontal, graphPadding)

              RoundedRectangle(cornerRadius: 10)
                .frame(width: graphWidth, height: viewModel.week_quiz_result[3].total == 0 ? 0.0 : CGFloat(viewModel.week_quiz_result[3].wrong / viewModel.week_quiz_result[3].total) * graphHeight)
                .foregroundColor(Color("Orange"))
                .padding(.horizontal, graphPadding)

              RoundedRectangle(cornerRadius: 10)
                .frame(width: graphWidth, height: viewModel.week_quiz_result[4].total == 0 ? 0.0 : CGFloat(viewModel.week_quiz_result[4].wrong / viewModel.week_quiz_result[4].total) * graphHeight)
                .foregroundColor(Color("Orange"))
                .padding(.horizontal, graphPadding)

              RoundedRectangle(cornerRadius: 10)
                .frame(width: graphWidth, height: viewModel.week_quiz_result[5].total == 0 ? 0.0 : CGFloat(viewModel.week_quiz_result[5].wrong / viewModel.week_quiz_result[5].total) * graphHeight )
                .foregroundColor(Color("Orange"))
                .padding(.horizontal, graphPadding)

              RoundedRectangle(cornerRadius: 10)
                .frame(width: graphWidth, height: viewModel.week_quiz_result[6].total == 0 ? 0.0 : CGFloat(viewModel.week_quiz_result[6].wrong / viewModel.week_quiz_result[6].total) * graphHeight)
                .foregroundColor(Color("Orange"))
                .padding(.horizontal, graphPadding)
            }
            .frame(height: self.graphHeight)
            
            HStack(alignment: .center) {
              Text("incorrect")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color("Orange"))
            }
          }
        }
        .padding(.horizontal, 20)
      }
      .onAppear{ viewModel.reload() }
      .padding(.bottom, 20)

//      HStack {
//        ZStack {
//          RoundedRectangle(cornerRadius: 20)
//            .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 100)
//            .foregroundColor(Color.white.opacity(1))
//          Text("")
//        }
//        Spacer()
//          .frame(width: 15)
//        ZStack {
//          RoundedRectangle(cornerRadius: 20)
//            .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 100)
//            .foregroundColor(Color.white.opacity(1))
//          Text("")
//        }
//      }
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



