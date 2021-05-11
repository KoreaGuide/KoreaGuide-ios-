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

        VStack(alignment: .leading) {
          HStack {
            Text(viewModel.word_list[displayItem].word_kor)
              .font(Font.custom("Bangla MN", size: 20))
              .fontWeight(.heavy)
          }
          .padding(10)
          HStack {
            Text(viewModel.word_list[displayItem].word_eng)
              .font(Font.custom("Bangla MN", size: 20))
              .fontWeight(.bold)
          }
          .padding(10)
          HStack {
            Text(viewModel.word_list[displayItem].meaning_kor1)
              .font(Font.custom("Bangla MN", size: 20))
              .multilineTextAlignment(.leading)
              .lineLimit(4)
          }
          .padding(10)
          HStack {
            Text(viewModel.word_list[displayItem].meaning_eng1)
              .font(Font.custom("Bangla MN", size: 20))
              .multilineTextAlignment(.leading)
              .lineLimit(4)
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

enum FolderName: String {
  case Added
  case Learning
  case Complete
}



struct WordListView: View {
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
  @ObservedObject var viewModel: WordListViewModel

  @State var showPopup: Int = -1

  // var input as option 1~3
  // @ObservedObject var navigation: Navigation

  @State var isLearnView = false
  @State var isTestView = false

  var body: some View {
    VStack {
    NavigationView {
      ZStack {
        Image("center_bg")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack(alignment: .center) {
          Spacer()
            .frame(height: 10)
          HStack {
            BackButton(tapAction: { self.presentationMode.wrappedValue.dismiss() })
            Spacer()
          }
          .padding(.horizontal, 20)
          
          Text("" + " Words List") // TODO:
            .foregroundColor(.white)
            .fontWeight(.heavy)
            .font(Font.custom("Bangla MN", size: 25))
            .padding(.vertical, 15)

          HStack {
            NavigationLink(destination: WordLearnView(viewModel: WordLearnViewModel(word_folder_id: viewModel.word_folder_id))
                            .navigationBarTitle("")
                            .navigationBarHidden(true), isActive: $isLearnView) { EmptyView() }
            Button(action: {
              self.isLearnView = true
            }, label: {
              LearnButton()
            })

            Spacer()
            NavigationLink(destination: WordTestSelectView(viewModel: WordTestSelectViewModel(word_folder_id: viewModel.word_folder_id, word_list: viewModel.word_list))
                            .navigationBarTitle("")
                            .navigationBarHidden(true), isActive: $isTestView) { EmptyView() }
            Button(action: {
              self.isTestView = true
            }, label: {
              TestButton()
            })
          }
          .padding(.horizontal, 30)
          Spacer()
            .frame(height: 20)

          WordGridView(rows: (viewModel.word_list.count + 1) / 2, columns: 2) { row, col in

            let num = row * 2 + col
            
            if viewModel.word_list.count == 0 {
              Text("This folder is empty.")
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .font(Font.custom("Bangla MN", size: 25))
                .padding(.vertical, 15)
            } else if (viewModel.word_list.count > num) && (num >= 0) {
              Button(action: {
                self.showPopup = num
              }, label: {
                WordCellView(viewModel: viewModel, index: num)
              })
            }
          }
          .padding(.bottom, 120)
         
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        if showPopup != -1 {
          WordPopup(displayItem: $showPopup, viewModel: viewModel)
            .padding(.top, -120)
            .ignoresSafeArea()
        }
      }
    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
  }
}
