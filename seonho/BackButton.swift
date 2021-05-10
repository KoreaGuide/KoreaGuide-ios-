//
//  BackButton.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/05/10.
//

import Foundation
import SwiftUI

struct BackButton: View {
  var tapAction: () -> Void = {}
  var body: some View {
    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
      Button(action: {
        tapAction()
      }, label: {
        Image(systemName: "chevron.left.square")
          .resizable()
          .frame(width: 30, height: 30, alignment: .center)
          .foregroundColor(.white)
      })
    }
  }
}
