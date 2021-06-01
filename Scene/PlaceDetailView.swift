//
//  PlaceDetailView.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/06/02.
//

import Combine
import Foundation
import SwiftUI
import Kingfisher
import MapKit
struct PlaceDetailView: View {
  @ObservedObject var viewModel: MyPageSceneViewModel

  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  var body: some View {
    ZStack {
      VStack {
        HStack {
          Button(action: {
            presentationMode.wrappedValue.dismiss()
          }, label: {
            Image("btn_left")
          })
          .padding(.leading, 10)
          Spacer()
          
          Text(splitTitle(title: viewModel.selectedPlace?.title ?? "")[1])
          
          Spacer()
          Image("bookmarkOn")
            .padding(.trailing, 15)
        }
        .frame(width: UIScreen.main.bounds.width, height: 55, alignment: .leading)
        .background(Color(.white))
        ScrollView(.vertical) {
          ImageViewFill(withURL: viewModel.selectedPlace?.first_image ?? "")
            .frame(width: UIScreen.main.bounds.width - 50,height:200)
            .padding(.bottom,10)
          VStack {
            Text(splitTitle(title: viewModel.selectedPlace?.title ?? "")[1])
              .lineLimit(2)
              .foregroundColor(.white)
              .font(.system(size: 20))
            Text(splitTitle(title: viewModel.selectedPlace?.title ?? "")[0])
              .lineLimit(2)
              .foregroundColor(.white)
              .font(.system(size: 20))
            Text(viewModel.selectedPlace?.overview_english ?? "")
              .foregroundColor(.white)
              .lineLimit(nil)
              .frame(alignment:.leading)
              .padding(.vertical, 10)
              .padding(.horizontal, 10)
          }
          .background(Color(#colorLiteral(red: 0.1019424871, green: 0.1215811893, blue: 0.2195759118, alpha: 1)))
//          KFImage.url(URL(string: viewModel.selectedPlace?.first_image ?? ""))
//            .placeholder { ImagePlaceHolder() }
//            .fade(duration: 0.25)
//            .resizable()
          PlaceMapView(viewModel: viewModel)
            .frame(height : 400)
        }
      }
    }
    .background(Image("background")
      .resizable()
      .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
      .ignoresSafeArea())
  }
}



func splitTitle(title : String) -> [String]
{
  let arr = title.components(separatedBy: " ")
  var kor = ""
  var eng = ""
  let regexEng = try! NSRegularExpression(pattern:"[A-Za-z]")
  arr.forEach {
    
    if regexEng.matches(in: $0, options: [], range: NSRange(location: 0, length: $0.count )).count == 0 {
      kor.append(" "+$0)
    } else {
      eng.append(" "+$0)
    }
  }
  
  return [kor,eng]
}


struct PlaceMapView: UIViewRepresentable{
  @ObservedObject var viewModel: MyPageSceneViewModel
  func makeUIView(context: Context) -> MyMapView {
    let view = MyMapView()
    view.delegate = context.coordinator
    view.addAnnotation(context.coordinator.makePin())
    
    return view
  }
  func makeCoordinator() -> (Coordinator) {
    return Coordinator(viewModel: viewModel)
  }
  func updateUIView(_: MyMapView, context _: Context) {}

  class Coordinator : NSObject, MKMapViewDelegate {
    @ObservedObject var viewModel: MyPageSceneViewModel
    init(viewModel: MyPageSceneViewModel) {
      self.viewModel = viewModel
    }
    func makePin() -> MKPointAnnotation {
      let pin = MKPointAnnotation()
      pin.title = viewModel.selectedPlace?.title
      pin.coordinate = CLLocationCoordinate2D(latitude: Double((viewModel.selectedPlace?.map_y!)!)!, longitude: Double((viewModel.selectedPlace?.map_x!)!)!)
      return pin
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
  }
}
