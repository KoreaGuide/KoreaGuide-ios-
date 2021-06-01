//
//  PhotoPicker.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/06/01.
//

import Combine
import Foundation
import PhotosUI
import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
  @Environment(\.presentationMode) var presentationMode
  @Binding var isPresented: Bool
  @Binding var selectionLimit : Int
  var images: (UIImage) -> ()
  func makeUIViewController(context: Context) -> PHPickerViewController {
    // 권한 있는지 먼저 확인하기
    let requiredAccessLevel: PHAccessLevel = .readWrite
    PHPhotoLibrary.requestAuthorization(for: requiredAccessLevel) { authorizationStatus in
      switch authorizationStatus {
      case .notDetermined:
        // TODO: 권한 팝업 다시 띄워주기?
        print("not determined")
      case .restricted:
        print("restricted?")
      case .denied:
        // TODO: 권한 팝업 다시 띄워주기?
        print("denied")
      case .authorized:
        print("authorization granted")
      case .limited:
        print("limited authorization granted")
      default: // FIXME: Implement handling for all authorizationStatus
        print("Unimplemented")
      }
    }
    var configuration = PHPickerConfiguration()
    configuration.selectionLimit = self.selectionLimit //사진 선택할 수 있는 갯수 지정
    configuration.filter = .any(of: [.images]) // 동영상, livePhoto 필요하면 추가
    configuration.preferredAssetRepresentationMode = .current
    let controller = PHPickerViewController(configuration: configuration)
    controller.delegate = context.coordinator
  
    return controller
  }

  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  // Use a Coordinator to act as your PHPickerViewControllerDelegate
  class Coordinator: PHPickerViewControllerDelegate {
    private var parent: PhotoPicker

    init(_ parent: PhotoPicker) {
      self.parent = parent
    }
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      guard !results.isEmpty else {
        return
      }
      for image in results {
        image.itemProvider.loadObject(ofClass: UIImage.self) { selectedImage, error in
          if let error = error {
            print(error.localizedDescription)
            return
          }
          guard let uiImage = selectedImage as? UIImage else {
            print("unable to unwrap image as UIImage")
            return
          }
          print(uiImage)
          self.parent.images(uiImage)
          DispatchQueue.main.async {
            self.parent.isPresented = false
          }
        }
      }
       // Set isPresented to false because picking has finished.
    }
  }
}
