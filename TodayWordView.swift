//
//  TodayWordView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/26.
//

import Foundation
import SwiftUI

struct TodayWordView: View {
  @ObservedObject var viewModel: TodayWordViewModel
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

  var backButton: some View {
    // 뒤로가기
    Button(action: {
      if viewModel.word!.added == true {
        viewModel.addWord()
      }
      else{
        
      }
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
        Image("background")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          HStack {
            Text("Word of Today")
              .foregroundColor(.white)
              .fontWeight(.heavy)
              .font(Font.custom("Bangla MN", size: 30))
            Spacer()
          }
          .padding(.horizontal, 20)

          Image("mae")
            .resizable()
            .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .center)
            .padding(.vertical, 10)
          HStack {
            Text(viewModel.word?.word.word_kor ?? "")
              .foregroundColor(.white)
              .font(Font.custom("Bangla MN", size: 25))
              .padding(.top, 10)
            Spacer()
          }
          .padding(.horizontal, 20)
          HStack {
            Text(viewModel.word?.word.pronunciation_eng ?? "")
              .foregroundColor(.white)
              .font(Font.custom("Bangla MN", size: 25))
              .padding(.top, 10)
            Spacer()
          }
          .padding(.horizontal, 20)
          HStack {
            Text(viewModel.word?.word.meaning_eng1 ?? "")
              .foregroundColor(.white)
              .font(Font.custom("Bangla MN", size: 25))
              .padding(.top, 10)
            Spacer()
          }
          .padding(.horizontal, 20)

          // add button
          // close button

          HStack {
            Text("Related Places")
              .foregroundColor(.white)
              .fontWeight(.semibold)
              .font(Font.custom("Bangla MN", size: 25))
              .padding(.top, 10)
            Image(systemName: "chevron.right.2")
              .resizable()
              .frame(width: 20, height: 20, alignment: .center)
              .foregroundColor(.white)

            Spacer()
          }
          .padding(.horizontal, 20)

          // List
          ScrollView(.horizontal) {
            HStack(spacing: 20) {
              ForEach(0 ..< 10) {
                Text("  Item \($0)  ")
                  .foregroundColor(.white)
                  .font(Font.custom("Bangla MN", size: 20))
                  .padding(.top, 10)
                  .frame(height: 50)
                  .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color("Navy")))
              }
            }
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 10)

          TodayInOutButton(viewModel: viewModel)

          Spacer()
            .frame(height: 180)
        }
      }
    }
    .navigationBarTitle("")
    .ignoresSafeArea()
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: self.backButton)
  }
}

struct TodayInOutButton: View {
  @ObservedObject var viewModel: TodayWordViewModel

  var body: some View {
    Button(action: {
      viewModel.word!.added.toggle()
      if viewModel.word!.added == true {
        // viewModel.added_word_id_list.append(viewModel.wordList[viewModel.currentWordCount].word_id)
      } else {
        // viewModel.added_word_id_list = viewModel.added_word_id_list.filter { $0 != viewModel.wordList[viewModel.currentWordCount].word_id }
      }
    }, label: {
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color("Navy"))
          .frame(width: UIScreen.main.bounds.width - 80, height: 50)

        HStack {
          Image(systemName: viewModel.word!.added ? "tray.and.arrow.up.fill" : "tray.and.arrow.down.fill")
            .resizable()
            .frame(width: 30, height: 30, alignment: .center)
            .foregroundColor(Color.orange)
            .padding(.horizontal, 5)
          Text(viewModel.word!.added ? "Get it out of my vocabulary" : "Put it in my vocabulary")
            .foregroundColor(Color.orange)
            .font(Font.custom("Bangla MN", size: 18))
            .padding(.top, 10)
        }
      }

    })
      .padding(.bottom, 20)
  }
}
