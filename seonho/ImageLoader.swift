//
//  ImageLoader.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/05/08.
//

import Combine
import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
  var didChange = PassthroughSubject<Data, Never>()
  var data = Data() {
    didSet {
      didChange.send(data)
    }
  }

  init(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data else { return }
      DispatchQueue.main.async {
        self.data = data
      }
    }
    task.resume()
  }
}

struct ImageView: View {
  @ObservedObject var imageLoader: ImageLoader
  @State var image = UIImage()

  init(withURL url: String) {
    imageLoader = ImageLoader(urlString: url)
  }

  var body: some View {
    Image(uiImage: image)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .onReceive(imageLoader.didChange) { data in
        self.image = UIImage(data: data) ?? UIImage()
      }
  }
}

