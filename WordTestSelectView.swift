//
//  WordTestSelectView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import Foundation
import SwiftUI

struct WordTestSelectView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
      ZStack {
        Image("right_bg")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          Text("단어장 이름")
            .foregroundColor(.white)
            .padding(.vertical, 20)

          Text("시험 볼 단어")
            .foregroundColor(.white)

          Rectangle()
            .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
            .foregroundColor(.orange)
            .padding(.horizontal, 20)

          Text("test type select")
            .foregroundColor(.white)

          // NavigationView {
          List {
            NavigationLink(destination: WordTestView(viewModel: WordTestViewModel())) {
              Text("1. Match the meaning of the word ") // 한국어 단어, 사진 -> 영어 단어 or 영어 설명
                .foregroundColor(.black)
            }
            NavigationLink(destination: WordTestView(viewModel: WordTestViewModel())) {
              Text("2. Listen to the pronunciation and match the word ") // 한국어 발음 -> 영어 단어 or 영어 설명
                .foregroundColor(.black)
            }
            NavigationLink(destination: WordTestView(viewModel: WordTestViewModel())) {
              Text("3. Complete the spelling of words letter by letter ") // 영어 단어 or 영어 설명 -> 한국어 단어
                .foregroundColor(.black)
            }
            NavigationLink(destination: WordTestView(viewModel: WordTestViewModel())) {
              Text("4. Enter the corresponding word in Korean ") // 영어 단어 or 영어 설명 -> 한국어 단어
                .foregroundColor(.black)
            }
          }
          // .background(Color.clear)
          // }
          // .navigationBarTitle("")
          // .navigationBarHidden(true)

          // four button
        }
        // .background(Color.gray.opacity(0.5))
      }
    }
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .navigationBarItems(leading: self.backButton)
    .ignoresSafeArea()
  }
}
