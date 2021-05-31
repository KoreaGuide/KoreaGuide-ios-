//
//  WordTestSelectView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import Foundation
import SwiftUI

struct rowItem: View {
  var content: String
  var body: some View {
    Text(content)
      .font(Font.custom("Bangla MN", size: 18))
      .fontWeight(.bold)
      .foregroundColor(.black)
      .frame(width: UIScreen.main.bounds.width - 40, height: 60, alignment: .center)
      .multilineTextAlignment(TextAlignment.center)
      .padding(.top, 5)
  }
}

//struct WordTestSelectNavigationLinks: View {
//  @ObservedObject var viewModel: WordTestSelectSceneViewModel
//  var body: some View{
//
//  }
//}

struct WordTestSelectScene: View {
  @ObservedObject var viewModel: WordTestSelectSceneViewModel

  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  var body: some View {
    // NavigationView {
    ZStack {
      Image("background")
        .resizable()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        .ignoresSafeArea()

      VStack {
        Spacer()
          .frame(height: 50)
        HStack {
          BackButton(tapAction: { self.presentationMode.wrappedValue.dismiss() })
          Spacer()
        }
        .padding(.horizontal, 20)

        Text("Let's see how much \nyou're moving forward !")
          .font(Font.custom("Bangla MN", size: 25))
          .foregroundColor(.white)
          .padding(.vertical, 20)
          .multilineTextAlignment(.center)
          .lineLimit(3)

        Text("Number of Words to Test: " + String(viewModel.word_list.count))
          .font(Font.custom("Bangla MN", size: 14))
          .background(RoundedRectangle(cornerRadius: 10)
            .frame(width: 240, height: 50, alignment: .top)
            .foregroundColor(Color.white.opacity(0.8)))
          .padding(10)

        Text("Select word test type !")
          .font(Font.custom("Bangla MN", size: 20))
          .foregroundColor(.white)
          .fontWeight(.heavy)
          .padding(5)

        // NavigationView {
        VStack(alignment: .leading) {
          NavigationLink(destination: WordMatchTestView(viewModel: WordTestSceneViewModel(quiz_type: "MATCH", word_folder_id: viewModel.word_folder_id))
            .navigationBarTitle("")
            .navigationBarHidden(true)) {
            rowItem(content: " 1. Match the meaning of the word ") // 한국어 단어, 사진 -> 영어 단어 or 영어 설명
          }
          .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.white.opacity(0.8)))
          .padding(10)

          NavigationLink(destination: WordListenTestView(viewModel: WordTestSceneViewModel(quiz_type: "LISTEN", word_folder_id: viewModel.word_folder_id))
            .navigationBarTitle("")
            .navigationBarHidden(true)) {
            rowItem(content: " 2. Listen to the pronunciation \n and match the word ") // 한국어 발음 -> 영어 단어 or 영어 설명
          }
          .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.white.opacity(0.8)))
          .padding(10)
          NavigationLink(destination: WordSpellingEasyTestView(viewModel: WordTestSceneViewModel(quiz_type: "SPELLING_E", word_folder_id: viewModel.word_folder_id))
            .navigationBarTitle("")
            .navigationBarHidden(true)) {
            rowItem(content: " 3. Complete the spelling of words \n letter by letter ") // 영어 단어 or 영어 설명 -> 한국어 단어
          }
          .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.white.opacity(0.8)))
          .padding(10)
          NavigationLink(destination: WordSpellingHardTestView(viewModel: WordTestSceneViewModel(quiz_type: "SPELLING_H", word_folder_id: viewModel.word_folder_id))
            .navigationBarTitle("")
            .navigationBarHidden(true)) {
            rowItem(content: " 4. Enter the corresponding word \n in Korean by typing ") // 영어 단어 or 영어 설명 -> 한국어 단어
          }
          .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.white.opacity(0.8)))
          .padding(10)
        }
        .background(Color.clear)
        .padding(.bottom, 120)
      }
      // .background(Color.gray.opacity(0.5))
    }
    // }
    // .navigationBarTitle("")
    // .navigationBarHidden(true)
    // .navigationBarItems(leading: self.backButton)
    // .ignoresSafeArea()
  }
}
