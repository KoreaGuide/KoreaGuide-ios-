//
//  WordTestView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import Foundation
import SwiftUI

struct WordTestView: View {
  @ObservedObject var viewModel: WordTestViewModel

  var progressBar: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
          .opacity(0.3)
          .foregroundColor(Color(UIColor.systemTeal))

        Rectangle().frame(width: min(CGFloat(self.viewModel.progressValue) * geometry.size.width, geometry.size.width), height: geometry.size.height)
          .foregroundColor(Color(UIColor.systemBlue))
          .animation(.linear)
      }.cornerRadius(45.0)
    }
  }

  var body: some View {
    VStack {
      Text("test page")
      Text("3/3")

      // ProgressBar
      Text("3/3")
        .foregroundColor(.white)
      progressBar
        .frame(width: UIScreen.main.bounds.width - 100, height: 20, alignment: .center)

      // test box...
    }
  }
}

struct WordTestFinishView: View {
  var body: some View {
    VStack {
      Text("finish")
    }
  }
}
