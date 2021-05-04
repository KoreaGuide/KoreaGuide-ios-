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
          HStack {
            //Text(viewModel.word_list[displayItem].word)
          }
          .padding(10)
          HStack {
            //Text(viewModel.word_list[displayItem].word)
          }
          .padding(10)
          HStack {
           // Text(viewModel.word_list[displayItem].word)
          }
          .padding(10)
          HStack {
           // Text(viewModel.word_list[displayItem].word)
          }
          .padding(10)
        }
        .frame(width: 240, height: 240, alignment: .center)
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
    VStack {
      ZStack {
        RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.8))
          .frame(width: 150, height: 50, alignment: .center)
        HStack {
          Image(systemName: "book")
            .resizable()
            .foregroundColor(Color("Green"))
            .frame(width: 30, height: 30)
          Text("Learn")
            .foregroundColor(Color("Green"))
            .font(Font.custom("Bangla MN", size: 25))
            .padding(.top, 10)
        }
      }
      .frame(width: 150, height: 50, alignment: .center)
    }
  }
}

struct TestButton: View {
  var body: some View {
    VStack {
      ZStack {
        RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.8))
          .frame(width: 150, height: 50, alignment: .center)
        HStack {
          Image(systemName: "square.and.pencil")
            .resizable()
            .foregroundColor(Color("Green"))
            .frame(width: 30, height: 30)
          Text("Test")
            .foregroundColor(Color("Green"))
            .font(Font.custom("Bangla MN", size: 25))
            .padding(.top, 10)
        }
      }
      .frame(width: 150, height: 50, alignment: .center)
    }
  }
}

struct WordListView: View {
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
  // @State private var isShowingDetailView = false
  @ObservedObject var viewModel: WordListViewModel
  // @State private var action: Int? = 0

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
            Text("" + " Words List")
              .foregroundColor(.white)
              .fontWeight(.heavy)
              .font(Font.custom("Bangla MN", size: 25))
              .padding(.vertical, 15)

            HStack { // NavigationLazyView()
              NavigationLink(destination: WordLearnView().navigationBarHidden(true)) {
                LearnButton()
              }
              .isDetailLink(false)

              Spacer()

              /*
              NavigationLink(destination: WordTestSelectView(viewModel: WordTestSelectViewModel(wordlist: [WordInfo(word_id: 999, word: "시험중", meaning: "testing")])).navigationBarHidden(true))
                {
                  TestButton()
                }
                .isDetailLink(false)*/
            }
            .padding(.horizontal, 30)
            Spacer()
              .frame(height: 40)
            // Text("list here")

            /*
            WordGridView(rows: (viewModel.wordlist.count + 1) / 2, columns: 2) { row, col in

              let num = row * 2 + col

              if (viewModel.wordlist.count > num) && (num >= 0) {
                Button(action: {
                  self.showPopup = num
                }, label: {
                  WordCellView(word: $viewModel.wordlist[num])
                })
                
              }
            }*/
            
            
          }
        }
      }
      .navigationBarTitle("")
      .ignoresSafeArea()
      .navigationBarBackButtonHidden(true)
      .navigationBarItems(leading: self.backButton)
      // .navigationViewStyle(StackNavigationViewStyle())

      if showPopup != -1 {
        WordPopup(displayItem: $showPopup, viewModel: viewModel)
          .padding(.top, -120)
      }
    }
  }
}
