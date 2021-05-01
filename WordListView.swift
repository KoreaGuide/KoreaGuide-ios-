//
//  WordListView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import Foundation
import SwiftUI

struct WordPopup: View {
  @Binding var displayItem: Int
  @ObservedObject var viewModel: WordListViewModel

  var body: some View {
    ZStack {
      if self.displayItem != -1 {
        Color.black.opacity(displayItem != -1 ? 0.3 : 0).edgesIgnoringSafeArea(.all)

        VStack {
          // Text("word")
          Text(viewModel.wordlist[displayItem].word)
            .padding(10)
          // Text("meaning")
          Text(viewModel.wordlist[displayItem].meaning)
            .padding(10)

          Text("이게 무슨 말이냐면 어쩌고 저쩌고 응")
            .padding(10)

          Text("추가된 날짜 등")
            .padding(10)
        }
        .frame(width: 300, height: 300, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 27).fill(Color.white.opacity(1)))
      }
    }
    .ignoresSafeArea()
    .onTapGesture {
      self.displayItem = -1
    }
  }
}

struct LearnButton: View {
  var body: some View {
    Text("Learn")
      .frame(width: 120, height: 50, alignment: .center)
      .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.8)))
      .foregroundColor(Color("Navy"))
      .font(.title)
  }
}

struct TestButton: View {
  var body: some View {
    Text("Test")
      .frame(width: 120, height: 50, alignment: .center)
      .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.8)))
      .foregroundColor(Color("Navy"))
      .font(.title)
  }
}

struct WordListView: View {
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
  // @State private var isShowingDetailView = false
  @ObservedObject var viewModel: WordListViewModel

  @State var showPopup: Int = -1
  // var input as option 1~3
  // @ObservedObject var navigation: Navigation

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
    ZStack {
      NavigationView {
        ZStack {
          Image("center_bg")
            .resizable()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .ignoresSafeArea()

          VStack(alignment: .center) {
            Text("Words List")
              .foregroundColor(.white)
              .font(.title)
              .padding(.vertical, 20)

            HStack {
              NavigationLink(destination: WordLearnView()) {
                LearnButton()
                  .frame(width: 200, height: 100, alignment: .center)
              }
              .isDetailLink(false)
              Spacer()
              NavigationLink(destination: WordTestSelectView(viewModel: WordTestSelectViewModel(wordlist: [WordInfo(word_id: 999, word: "시험중", meaning: "testing")]))) {
                TestButton()
                  .frame(width: 200, height: 100, alignment: .center)
              }
              .isDetailLink(false)
            }
            .padding(.horizontal, 40)
            Spacer()
            Text("list here")

            WordGridView(rows: (viewModel.wordlist.count + 1) / 2, columns: 2) { row, col in

              let num = row * 2 + col

              if (viewModel.wordlist.count > num) && (num >= 0) {
                Button(action: {
                  self.showPopup = num
                }, label: {
                  WordCellView(word: $viewModel.wordlist[num])
                })
              }
            }
          }
        }
      }
      .navigationBarTitle("")
      .ignoresSafeArea()
      .navigationBarBackButtonHidden(true)
      .navigationBarItems(leading: self.backButton)
      .navigationViewStyle(StackNavigationViewStyle())

      if showPopup != -1 {
        WordPopup(displayItem: $showPopup, viewModel: viewModel)
          .padding(.top, -180)
      }
    }
  }
}
