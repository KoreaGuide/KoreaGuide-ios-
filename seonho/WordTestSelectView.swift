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
      .font(Font.custom("Bangla MN", size: 20))
      .fontWeight(.bold)
      .foregroundColor(.black)
      .frame(width: UIScreen.main.bounds.width - 40, height: 60, alignment: .center)
      .multilineTextAlignment(TextAlignment.center)
  }
}

struct WordTestSelectView: View {
  @ObservedObject var viewModel: WordTestSelectViewModel
  
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
          Text("Let's see how much you're moving forward !")
            .font(Font.custom("Bangla MN", size: 25))
            .foregroundColor(.white)
            .padding(.vertical, 20)

          Text("Words to test")
            .font(Font.custom("Bangla MN", size: 20))
            .foregroundColor(.white)
            .padding(10)

          Text("Number of Words : " + String(viewModel.word_list.count))
            .font(Font.custom("Bangla MN", size: 20))
            .background(Rectangle()
                          .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                          .foregroundColor(Color.white.opacity(0.8)))
            .padding(40)
        
          Text("Select word test type !")
            .font(Font.custom("Bangla MN", size: 20))
            .foregroundColor(.white)
            .fontWeight(.heavy)
            .padding(10)

          // NavigationView {
          VStack (alignment: .leading){
            NavigationLink(destination: WordTestView(viewModel: WordTestViewModel(quiz_type: "MATCH", word_folder_id: viewModel.word_folder_id))) {
              rowItem(content: " 1. Match the meaning of the word ") // 한국어 단어, 사진 -> 영어 단어 or 영어 설명
            }
            .background(Color.white.opacity(0.8))
            .padding(10)
            
            NavigationLink(destination: WordTestView(viewModel: WordTestViewModel(quiz_type: "MATCH", word_folder_id: viewModel.word_folder_id))) {
              rowItem(content: " 2. Listen to the pronunciation \n and match the word ") // 한국어 발음 -> 영어 단어 or 영어 설명
            
            }
            .background(Color.white.opacity(0.8))
            .padding(10)
            NavigationLink(destination: WordTestView(viewModel: WordTestViewModel(quiz_type: "MATCH", word_folder_id: viewModel.word_folder_id))) {
              rowItem(content: " 3. Complete the spelling of words \n letter by letter ") // 영어 단어 or 영어 설명 -> 한국어 단어
            }
            .background(Color.white.opacity(0.8))
            .padding(10)
            NavigationLink(destination: WordTestView(viewModel: WordTestViewModel(quiz_type: "MATCH", word_folder_id: viewModel.word_folder_id))) {
              rowItem(content: " 4. Enter the corresponding word \n in Korean by typing ") // 영어 단어 or 영어 설명 -> 한국어 단어
            }
            .background(Color.white.opacity(0.8))
            .padding(10)
          }
          .background(Color.clear)
          .padding(.bottom, 120)
          
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
