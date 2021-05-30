//
//  NavigationLazyView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/05/30.
//

import Foundation
import SwiftUI

struct NavigationLazyView<C: View>: View {
  let build: () -> C
  init(_ build: @autoclosure @escaping () -> C) {
    self.build = build
  }

  var body: C {
    build()
  }
}
