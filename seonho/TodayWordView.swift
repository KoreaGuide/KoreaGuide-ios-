//
//  TodayWordView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/26.
//

import Foundation
import SwiftUI
import UIKit

// destination: TodayWordView(viewModel: TodayWordViewModel()) 이런식으로 진입

struct TodayWordView: View {
  @ObservedObject var viewModel: TodayWordViewModel
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
  var body: some View {
    NavigationView {
      ZStack {
        Image("background")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          Spacer()
            .frame(height: 20)
          HStack {
            Rectangle()
              .foregroundColor(.white)
              .frame(width: 50, height: 2, alignment: .center)
            Text(" Word of Today")
              .foregroundColor(.white)
              .fontWeight(.heavy)
              .font(Font.custom("Bangla MN", size: 30))
            Rectangle()
              .foregroundColor(.white)
              .frame(width: 50, height: 2, alignment: .center)
          }
          .padding(.horizontal, 1)

          Image("") // image가 안나올수도
            .resizable()
            .frame(width: 300, height: 200, alignment: .center)
            .padding(.vertical, 5)
          HStack {
            VStack(alignment: .leading) {
              Text("Word : " + (viewModel.word?.word.word_kor ?? ""))
                .foregroundColor(.white)
                .font(Font.custom("Bangla MN", size: 25))
                .padding(.top, 10)
                .padding(.trailing, 10)
              Text("Pronunciation : " + (viewModel.word?.word.pronunciation_eng ?? ""))
                .foregroundColor(.white)
                .font(Font.custom("Bangla MN", size: 25))
                .padding(.top, 10)
            }
            Spacer()
          }
          .padding(.horizontal, 20)
          HStack {
            VStack(alignment: .leading) {
              Text("Meaning in Korean : ")
                .foregroundColor(.white)
                .font(Font.custom("Bangla MN", size: 20))

              Text(viewModel.word?.word.meaning_kor1 ?? "")
                .foregroundColor(.white)
                .font(Font.custom("Bangla MN", size: 20))

              Text("Meaning in English : ")
                .foregroundColor(.white)
                .font(Font.custom("Bangla MN", size: 20))

              Text(viewModel.word?.word.meaning_eng1 ?? "")
                .foregroundColor(.white)
                .font(Font.custom("Bangla MN", size: 20))
            }
            Spacer()
          }
          .padding(.horizontal, 20)

          // add button
          // close button

          HStack {
            Text("Related Places")
              .foregroundColor(.white)
              .fontWeight(.semibold)
              .font(Font.custom("Bangla MN", size: 18))
              .padding(.top, 10)
            Image(systemName: "chevron.right.2")
              .resizable()
              .frame(width: 15, height: 15, alignment: .center)
              .foregroundColor(.white)

            Spacer()
          }
          .padding(.horizontal, 20)

          // List
          ScrollView(.horizontal) {
            HStack(spacing: 20) {
              ForEach(0 ..< 10) {
                Text("  Place \($0)  ")
                  .foregroundColor(.white)
                  .font(Font.custom("Bangla MN", size: 16))
                  .frame(height: 40)
                  .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color("Navy")))
              }
            }
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 10)

          TodayInOutButton(viewModel: viewModel)

          Spacer()
            .frame(height: 80)
        }
      }
    }

    // .navigationBarBackButtonHidden(true)
    .navigationBarHidden(true)
    // .navigationBarItems(leading: self.backButton)
  }
}

struct TodayInOutButton: View {
  @ObservedObject var viewModel: TodayWordViewModel

  var body: some View {
    Button(action: {
      viewModel.word!.added.toggle()
      if viewModel.word!.added == true {
        viewModel.addWord()
      } else {
        viewModel.removeWord()
      }
    }, label: {
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color("Navy"))
          .frame(width: UIScreen.main.bounds.width - 80, height: 50)

        HStack {
          Image(systemName: viewModel.word?.added ?? false ? "tray.and.arrow.up.fill" : "tray.and.arrow.down.fill")
            .resizable()
            .frame(width: 30, height: 30, alignment: .center)
            .foregroundColor(Color.orange)
            .padding(.horizontal, 5)
          Text(viewModel.word?.added ?? false ? "Get it out of my vocabulary" : "Put it in my vocabulary")
            .foregroundColor(Color.orange)
            .font(Font.custom("Bangla MN", size: 18))
            .padding(.top, 10)
        }
      }

    })
      .padding(.bottom, 20)
  }
}
