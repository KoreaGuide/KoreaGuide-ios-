//
//  wordAddView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/14.
//

import Foundation
import SwiftUI

struct WordInfo {
  let word: String // kor
  let meaning: String // eng
  let wordId: Int
}

struct WordAddView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  var totalWordCount: Int // 1~
  var currentWord: Int // 1~
  @State var progressValue: Float = 0.5
  var wordlist: [WordInfo]

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
        HStack {
          // place title
          Label("place title", systemImage: "book.fill") // icon change
            .foregroundColor(.white)
        }

        // label
        Text("3/3")
          .foregroundColor(.white)
        ProgressBar(value: $progressValue)
          .frame(width: UIScreen.main.bounds.width - 100, height: 20, alignment: .center)

        // label
        Text("Swipe up to add")
          .foregroundColor(.white)

        HStack {
          // left
          Button(action: {}, label: {
            Image(systemName: "chevron.left.circle")
              .resizable()
            .scaledToFit()
              .frame(width: 30, height: 30, alignment: .center)
              .foregroundColor(.white)
            
          })

          // box
          WordBox()

          // right
          Button(action: {}, label: {
            Image(systemName: "chevron.right.circle")
              .resizable()
            .scaledToFit()
              .frame(width: 30, height: 30, alignment: .center)
              .foregroundColor(.white)
          })
        }
        
        Spacer()
          .frame(height: 120, alignment: .center)
      }
      }
      
    }
    .navigationBarTitle("")
    .ignoresSafeArea()
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: self.backButton)
  }
}

struct ProgressBar: View {
  @Binding var value: Float

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
          .opacity(0.3)
          .foregroundColor(Color(UIColor.systemTeal))

        Rectangle().frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
          .foregroundColor(Color(UIColor.systemBlue))
          .animation(.linear)
      }.cornerRadius(45.0)
    }
  }
}

struct WordBox: View {
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .fill(Color("Navy"))
        .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 5 * 3)

      VStack {
        Image("mae")
          .resizable()
          .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          .cornerRadius(10)
        Spacer().frame(height: 30)
        Text("word")
          .foregroundColor(.white)
        Text("pronun")
          .foregroundColor(.white)
        Text("meaning")
          .foregroundColor(.white)
        Button(action: {
          // back to place detail page
        }, label: {
          Text("play")
        })
      }
    }
  }
}

struct WordAddFinishView: View {
  var body: some View {
    Text("place title")

    Rectangle() // 총 단어 개수, 담은 개수, 어쩌고

    // button 장소페이지로 돌아가기
    // button 단어장으로 가기
  }
}
