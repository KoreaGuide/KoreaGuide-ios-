//
//  ImagePlaceHolder.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/06/01.
//
import Combine
import Foundation
import SwiftUI
struct ImagePlaceHolder: View {
  var body: some View {
    ZStack(alignment: .center) {
      Color("steel")
        .opacity(18)
      Image("memo")
        .frame(width: 40, height: 48, alignment: .center)
    }
  }
}
