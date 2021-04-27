//
//  WordLearnView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import Foundation
import SwiftUI

struct WordLearnView: View {
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

  var backButton: some View {
    // 뒤로가기
    Button(action: {
      self.presentationMode.wrappedValue.dismiss()
    }, label: {
      Image(systemName: "chevron.left.square")
        .resizable()
        .scaledToFit()
        .padding(.top, 15)
        .padding(.trailing, 20)
        .padding(.bottom, 10)
        .frame(width: 50, height: 50, alignment: .center)
        .foregroundColor(.white)
    })
  }

  var body: some View {
    NavigationView {
      ZStack{
        
        Image("background")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()
        
        VStack {
          Text("learn view")

          Text("")

          // WordBox(viewModel: viewModel)
        }
      }
    }
    .navigationBarTitle("")
    .ignoresSafeArea()
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: self.backButton)
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct WordLearnFinishView: View {
  var body: some View {
    Text("end of learning")
    // 뭘 보여주지... 잘햇다?
    // learn 도 기록이 되면 공부한 횟수라든가...
    // Button()
  }
}

